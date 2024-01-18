-- Create stored procedure ComputeAverageWeightedScoreForUsers
DELIMITER //
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE user_id_val INT;
    DECLARE done INT DEFAULT 0;
    DECLARE cur CURSOR FOR SELECT id FROM users;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Declare variables to store weighted sum and total weight for each user
    DECLARE weighted_sum FLOAT;
    DECLARE total_weight INT;

    -- Loop through each user
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO user_id_val;
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Initialize variables
        SET weighted_sum = 0;
        SET total_weight = 0;

        -- Calculate weighted sum and total weight for the user
        SELECT SUM(corrections.score * projects.weight), SUM(projects.weight)
        INTO weighted_sum, total_weight
        FROM corrections
        JOIN projects ON corrections.project_id = projects.id
        WHERE corrections.user_id = user_id_val;

        -- Update the user's average_score
        UPDATE users
        SET average_score = IF(total_weight > 0, weighted_sum / total_weight, 0)
        WHERE id = user_id_val;
    END LOOP;
    CLOSE cur;
END //
DELIMITER ;
