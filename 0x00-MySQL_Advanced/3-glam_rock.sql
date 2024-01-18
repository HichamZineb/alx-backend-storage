-- Import the metal_bands table dump
-- You may use the source command to execute the SQL file
-- Example: source path/to/metal_bands.sql

-- List all bands with Glam rock as their main style, ranked by their longevity
SELECT
    band_name,
    COALESCE(split, 2022) - formed as lifespan
FROM
    metal_bands
WHERE
    style LIKE '%Glam rock%'
ORDER BY
    lifespan DESC;
