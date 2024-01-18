-- Function: SafeDiv
-- Description: Safely divides the first number by the second number or returns 0 if the second number is equal to 0.
-- Parameters:
--   a - INT: Numerator
--   b - INT: Denominator
-- Returns: DECIMAL(10, 6) - Result of the division or 0 if the denominator is 0
CREATE FUNCTION SafeDiv(a INT, b INT) RETURNS DECIMAL(10, 6)
BEGIN
    IF b = 0 THEN
        RETURN 0;
    ELSE
        RETURN a / b;
    END IF;
END;
