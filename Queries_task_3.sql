/*
Вывести информацию о работниках, родившихся позже 1975 года
*/
SELECT
  first_nm
  ,last_nm
  ,middle_nm
  ,birth_dt
  ,mobile_phone_no
FROM
  EMPLOYEE
WHERE
  birth_dt > '1975-12-31';

/*
Посчиать среднее значение массы собранного урожая(2 знака после запятой)
в период между 10 и 14 августа 2016
 */
SELECT
  ROUND(AVG(weight_amt), 2) AS average_weight
FROM
  TRIP
WHERE
  trip_dt BETWEEN '2016-08-10' AND '2016-08-14';

/*
Вывести информацию о полях (id, площадь, деревня в которой расположена),
 на которых растет "Пшеница Льговская 4"
 */
SELECT
  FIELD.field_id
  ,FIELD.area_amt
  ,VILLAGE.village_nm
FROM
  FIELD
  INNER JOIN VILLAGE
    ON FIELD.village_id = VILLAGE.village_id
WHERE
  FIELD.field_id IN (
    SELECT
      field_id
    FROM
      FIELD
      INNER JOIN CROP
        ON FIELD.crop_id = CROP.crop_id
    WHERE
      CROP.crop_nm = 'Пшеница Льговская 4'
  );

/*
Вывести информацию о работнике, совершившего больше всего рейсов за все время
*/
WITH A AS (
  SELECT
    employee_id,
    COUNT(trip_id) AS trip_cnt
  FROM
    TRIP
  GROUP BY
    employee_id
)
SELECT
  EMPLOYEE.first_nm
  ,EMPLOYEE.last_nm
  ,EMPLOYEE.middle_nm
  ,EMPLOYEE.birth_dt
  ,EMPLOYEE.mobile_phone_no
FROM
  A
  INNER JOIN EMPLOYEE
    ON A.employee_id = EMPLOYEE.employee_id
WHERE
  trip_cnt = (
    SELECT
      MAX(trip_cnt)
    FROM
      A
);

/*
Найти информацию о машине(название) и работнике, работавшей на ней,
собравшем больше всего урожая за один рейс в период между 9 и 11 августа 2016 года
 */
SELECT
  EMPLOYEE.first_nm
  ,EMPLOYEE.last_nm
  ,EMPLOYEE.middle_nm
  ,EMPLOYEE.birth_dt
  ,EMPLOYEE.mobile_phone_no
  ,AGRICULTURAL_MACHINERY.machinery_nm
FROM EMPLOYEE
  INNER JOIN (
               SELECT
                 employee_id
                 ,machinery_id
               FROM
                 TRIP
               WHERE
                 weight_amt = (
                   SELECT MAX(weight_amt)
                   FROM
                     TRIP
                   WHERE
                     trip_dt BETWEEN '2016-08-09' AND '2016-08-11'
                 )
             ) AS T
    ON EMPLOYEE.employee_id = T.employee_id
  INNER JOIN AGRICULTURAL_MACHINERY
    ON T.machinery_id = AGRICULTURAL_MACHINERY.machinery_id;
