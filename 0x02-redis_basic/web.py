#!/usr/bin/env python3
"""
Caching request module with Tracking
"""
import redis
import requests
from functools import wraps
from typing import Callable


def track_and_cache_page(fn: Callable) -> Callable:
    """ Decorator for caching and tracking page requests
    """
    @wraps(fn)
    def wrapper(url: str) -> str:
        """ Wrapper that:
            - checks if a URL's data is cached
            - tracks how many times get_page is called
        """
        redis_client = redis.Redis()
        redis_key_count = f'count:{url}'
        redis_key_page = f'{url}'

        redis_client.incr(redis_key_count)
        cached_page = redis_client.get(redis_key_page)

        if cached_page:
            return cached_page.decode('utf-8')

        response = fn(url)
        redis_client.setex(redis_key_page, 10, response)

        return response
    return wrapper


@track_and_cache_page
def get_page(url: str) -> str:
    """ Makes an HTTP request to a given endpoint
    """
    response = requests.get(url)
    return response.text
