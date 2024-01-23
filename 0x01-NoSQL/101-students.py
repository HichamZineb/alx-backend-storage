#!/usr/bin/env python3
"""
Top students
"""


def top_students(mongo_collection):
    """
    Return all students sorted by average score
    """
    students = mongo_collection.find()
    top_students_list = []

    for student in students:
        total_score = 0
        num_topics = len(student.get("topics", []))

        for topic in student.get("topics", []):
            total_score += topic.get("score", 0)

        average_score = total_score / num_topics if num_topics > 0 else 0
        student["averageScore"] = average_score
        top_students_list.append(student)

    sorted_students = sorted(
            top_students_list,
            key=lambda x: x.get("averageScore"),
            reverse=True)

    return sorted_students
