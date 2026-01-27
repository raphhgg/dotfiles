---
name: api-conventions
description: API design patterns and conventions for consistent REST APIs. Use when creating or reviewing API endpoints.
---

# API Design Conventions

When writing API endpoints:

## Naming
- Use plural nouns for resources: `/users`, `/posts`
- Use kebab-case for multi-word resources: `/user-profiles`
- Nest related resources: `/users/{id}/posts`

## HTTP Methods
- GET: Retrieve (never mutate)
- POST: Create new resource
- PUT: Replace entire resource
- PATCH: Partial update
- DELETE: Remove resource

## Response Format
```json
{
  "data": {},
  "meta": {
    "total": 100,
    "page": 1
  },
  "errors": []
}
```

## Error Handling
Always return consistent error objects with `code`, `message`, and `details`.