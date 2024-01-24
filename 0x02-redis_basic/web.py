#!/usr/bin/env python3
"""
Web Cache Module

Defines a decorator to cache and track accessed URLs.
"""

import requests
import redis
from typing import Callable

# Redis client instance
redis_client = redis.Redis()


def cache_and_track(fn: Callable) -> Callable:
    """
    Decorator function to cache and track accessed URLs.

    Args:
        fn (Callable): The function to be decorated.

    Returns:
        Callable: Decorated function.
    """
    def wrapper(url: str) -> str:
        count_key, content_key = f"count:{url}", f"content:{url}"

        cached_content = redis_client.get(content_key)
        if cached_content:
            redis_client.incr(count_key)
            return cached_content.decode("utf-8")

        response = requests.get(url)
        content = response.text

        redis_client.setex(content_key, 10, content)
        redis_client.incr(count_key)

        return content

    return wrapper
