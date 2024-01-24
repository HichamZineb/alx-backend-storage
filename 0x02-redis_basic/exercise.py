#!/usr/bin/env python3
"""
Redis exercise
"""
import redis
import uuid
from typing import Union


class Cache:
    """
    Cache class for storing data in Redis
    """

    def __init__(self) -> None:
        """
        Initializes a Cache instance with a Redis client
        and flushes the database.
        """
        self._redis = redis.Redis()
        self._redis.flushdb()

    def store(self, data: Union[str, bytes, int, float]) -> str:
        """
        Generates a random key, stores the input data in Redis using the key
        and returns the key.
        """
        key = str(uuid.uuid4())
        self._redis.set(key, data)
        return key
