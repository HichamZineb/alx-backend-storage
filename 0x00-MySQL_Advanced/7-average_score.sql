-- Create a stored procedure ComputeAverageScoreForUser
DELIMITER //
CREATE PROCEDURE ComputeAverageScoreForUser(
    IN p_user_id INT
)
BEGIN
    DECLARE total_score FLOAT;
    DECLARE total_projects INT;

    -- Calculate total score and total number of projects for the user
    SELECT SUM(score) INTO total_score, COUNT(DISTINCT project_id) INTO total_projects
    FROM corrections
    WHERE user_id = p_user_id;

    -- Calculate and update the average score for the user
    UPDATE users
    SET average_score = IF(total_projects > 0, total_score / total_projects, 0)
    WHERE id = p_user_id;
END;
//
DELIMITER ;
