# Diagnostic Logs

## Timeline of Events

### T+0ms: API Request Received

```json
{
  "method": "POST",
  "path": "/api/[endpoint]",
  "body": {...}
}
```

### T+Xms: Validation Passed

```json
{
  "isValid": true,
  "dto": {...}
}
```

### T+Xms: Database Query Executed

```json
{
  "query": "SELECT * FROM [table] WHERE [condition]",
  "executionTime": "Xms",
  "rowCount": X
}
```

### T+Xms: ERROR OCCURRED

```json
{
  "error": "[Error message]",
  "stack": "...",
  "context": {...}
}
```

## Key Observations

- [Observation 1]
- [Observation 2]
- [Pattern detected]
