/*Представления*/

/*Информация о работниках со скрытым номером телефона*/
CREATE VIEW EMPLOYEES AS (
  SELECT
    first_nm
    ,last_nm
    ,middle_nm
    , SUBSTRING(mobile_phone_no, 0, 4) || '********' AS mobile_phone
  FROM
    EMPLOYEE
);

/*Информация о технике*/
CREATE VIEW MACHINERY AS (
  SELECT
    machinery_nm
    ,release_dt
    , CASE
    WHEN AGRICULTURAL_MACHINERY.type_code = 1
      THEN
        'combine_harvester'
    WHEN AGRICULTURAL_MACHINERY.type_code = 2
      THEN
        'forage_harvester'
    ELSE
      NULL
    END AS type
  FROM
    AGRICULTURAL_MACHINERY
);

/*Информация о культурах*/
CREATE VIEW CROPS AS (
  SELECT
    crop_nm
    ,crop_desc AS description
    ,crop_yield_rt AS productivity
  FROM
    CROP
);

/*Информация о потенциальных покупатеях*/
CREATE VIEW POSSIBLE_BUYERS AS (
    SELECT
      buyer_nm
      ,mobile_phone_no
    FROM
      POSSIBLE_BUYER
);

/*Иформация о полях*/
CREATE VIEW FIELD_DESC AS (
    SELECT
      FIELD.area_amt
      ,VILLAGE.village_nm
    FROM
      FIELD
        INNER JOIN VILLAGE
          ON FIELD.village_id = VILLAGE.village_id
);

/*Информация о 10 последних рейсах(кто, когда, на какой технике) */
CREATE VIEW TRIPS AS (
  SELECT
    TRIP.trip_dt
    ,TRIP.weight_amt
    ,AGRICULTURAL_MACHINERY.machinery_nm
    ,EMPLOYEE.first_nm
    ,EMPLOYEE.last_nm
  FROM
    TRIP
      INNER JOIN AGRICULTURAL_MACHINERY
        ON TRIP.machinery_id = AGRICULTURAL_MACHINERY.machinery_id
      INNER JOIN EMPLOYEE
        ON TRIP.employee_id = EMPLOYEE.employee_id
  ORDER BY TRIP.trip_dt DESC
  LIMIT 10
);