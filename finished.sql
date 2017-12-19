/*1) Вычислить количество преступлений на 10 000 населения, 
для каждого вида преступления, в каждом районе и для каждой даты.*/

SELECT a.crime_count, a.crime_region, a.crime_time FROM distinct_crimes a, populations b 
WHERE a.crime_region = b.code_population and b.population >= 10000 GROUP BY a.crime_count, a.crime_region, a.crime_time;

/*2) Вычислить среднее количество преступлений на 10 000 населения по районам относительно вида преступления и даты создания отчета.*/

 SELECT AVG(a.crime_count), a.crime_time FROM distinct_crimes a, populations b 
 WHERE a.crime_region = b.code_population and b.population >= 10000 GROUP BY a.crime_region, a.crime_time;

/*3) Вычислить стандартное отклонение от среднего для преступлений на 
10 000 населения по районам относительно вида преступления и даты создания отчета.*/

 SELECT FORMAT(STD(c.avg_crime_count),2) as deviation, c.crime_time as create_time 
 FROM (select AVG(a.crime_count) as avg_crime_count, a.crime_time as crime_time FROM distinct_crimes a, populations b 
 WHERE a.crime_region = b.code_population and b.population >= 10000 GROUP BY a.crime_count, a.crime_time) c;

/*4) Вычислить отклонение от среднего количества преступлений на 10 000 населения в процентах.*/
 SELECT FORMAT(STD(aaa.avg_crime_count_percent),2) as deviation FROM (SELECT AVG(aa.crime_count_percent) as avg_crime_count_percent 
 	FROM (SELECT a.crime_count/ SUM(a.crime_count) * 100 as crime_count_percent from distinct_crimes a, populations b 
 	WHERE a.crime_region = b.code_population and b.population >= 10000 GROUP BY a.crime_count) aa GROUP BY aa.crime_count_percent) aaa

/*5) Рассчитать доли преступлений (всех районов) для каждой даты формирования отчета:*/

select a.crime_count/COUNT(a.crime_time) from distinct_crimes a, populations b 
WHERE a.crime_region = b.code_population GROUP BY a.crime_count;