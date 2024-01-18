-- Function: SafeDiv
-- Description: Safely divides the first number by the second number or returns 0 if the second number is equal to 0.
-- Parameters:
--   a - INT: Numerator
--   b - INT: Denominator
-- Returns: DECIMAL(10, 6) - Result of the division or 0 if the denominator is 0

DELIMITER //

DROP FUNCTION IF EXISTS SafeDiv;
CREATE FUNCTION SafeDiv(a INT, b INT)
RETURNS FLOAT DETERMINISTIC
BEGIN
	RETURN (IF (b = 0, 0, a / b));
END //

DELIMITER ;
