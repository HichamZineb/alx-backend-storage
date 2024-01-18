-- Import the metal_bands table dump
-- You may use the source command to execute the SQL file
-- Example: source path/to/metal_bands.sql

-- List all bands with Glam rock as their main style, ranked by their longevity
SELECT
    band_name,
    IFNULL(
        IF(split = 0, 0, formed + split),
        IF(splitted_formed = 0, 0, 2022 - splitted_formed)
    ) AS lifespan
FROM
    metal_bands
WHERE
    style = 'Glam rock'
ORDER BY
    lifespan DESC,
    band_name ASC;
