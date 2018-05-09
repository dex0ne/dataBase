/*CRUD 1*/

INSERT INTO FERTILIZER (fertilizer_nm, shelf_life_dt)
    VALUES ('Покон', '2018-02-28')
      ,('Бона Форте', '2018-09-20')
      ,('Аммофос', '2018-04-30')
      ,('Сапропель', '2018-03-16');

SELECT
  *
FROM
  FERTILIZER;

DELETE FROM
  FERTILIZER
WHERE
  shelf_life_dt < CURRENT_DATE;

UPDATE
  FERTILIZER
SET
  shelf_life_dt = '2020-12-31'
WHERE
  fertilizer_nm = 'Бона Форте';

/*CRUD 2 */
INSERT INTO AGRICULTURAL_MACHINERY (type_code, machinery_nm, release_dt)
    VALUES ('1', 'Акрос 530', '2008-04-10')
    ,('2', 'Палессе GS812', '2019-03-18')
    ,('1', 'Claas Tucano 450', '2020-04-09')
    ,('1', 'Нива Эффект', '2013-03-7')
    ,('2', 'Палессе GS575', '2014-03-01');

SELECT
  machinery_nm
  ,release_dt
FROM
  AGRICULTURAL_MACHINERY
WHERE
  machinery_nm LIKE 'JohnDeere%';

DELETE FROM
  AGRICULTURAL_MACHINERY
WHERE
  machinery_nm LIKE 'Палессе %' AND release_dt > CURRENT_DATE;

UPDATE
  AGRICULTURAL_MACHINERY
SET
  release_dt = '2009-04-04'
  ,type_code = 2
WHERE
  machinery_nm LIKE 'New Holland %';