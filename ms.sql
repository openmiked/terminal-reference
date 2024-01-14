SELECT *
FROM Serilog
WHERE ISJSON(LogEvent) > 0
  AND JSON_VALUE(LogEvent, '$.Properties.CorrelationId') = ''