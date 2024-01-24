#!/usr/bin/env python3
"""
Web Cache Module

Defines the WebCache class for caching and tracking accessed URLs.
"""

import requests
import redis
from typing import Optional


class WebCache:
    """
    WebCache class for caching and tracking accessed URLs.

    Attributes:
        _redis: Redis client instance.
    """

    def __init__(self):
        """Initializes the WebCache instance with a Redis client."""
        self._redis = redis.Redis()

    def get_page(self, url: str) -> str:
        """
        Fetches the content of a URL, tracks access count
        and caches the content with expiration.

        Args:
            url (str): URL to fetch content from.

        Returns:
            str: Content of the URL.
        """
        count_key, content_key = f"count:{url}", f"content:{url}"

        cached_content = self._redis.get(content_key)
        if cached_content:
            self._redis.incr(count_key)
            return cached_content.decode("utf-8")

        response = requests.get(url)
        content = response.text

        self._redis.setex(content_key, 10, content)
        self._redis.incr(count_key)

        return content
