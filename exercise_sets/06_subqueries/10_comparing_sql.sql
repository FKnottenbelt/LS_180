-- 10 Comparing SQL Statements

-- In this exercise, we'll use EXPLAIN ANALYZE to compare the
-- efficiency of two SQL statements. These two statements are actually
-- from the "Query From a Virtual Table" exercise in this set. In
-- that exercise, we stated that our subquery-based solution:

-- SELECT MAX(bid_counts.count) FROM
--   (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;

-- was actually faster than the simpler equivalent without subqueries:

-- SELECT COUNT(bidder_id) AS max_bid FROM bids
--   GROUP BY bidder_id
--   ORDER BY max_bid DESC
--   LIMIT 1;

-- In this exercise, we will demonstrate this fact.

-- Run EXPLAIN ANALYZE on the two statements above. Compare the
-- planning time, execution time, and the total time required to run
-- these two statements. Also compare the total "costs". Which
-- statement is more efficient and why?

EXPLAIN ANALYZE SELECT MAX(bid_counts.count) FROM
  (SELECT COUNT(bidder_id) FROM bids GROUP BY bidder_id) AS bid_counts;

                                                  QUERY PLAN
---------------------------------------------------------------------------------------------------------------
 Aggregate  (cost=37.15..37.16 rows=1 width=8) (actual time=0.020..0.020 rows=1 loops=1)
   ->  HashAggregate  (cost=32.65..34.65 rows=200 width=4) (actual time=0.016..0.017 rows=6 loops=1)
         Group Key: bids.bidder_id
         ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.003..0.004 rows=26 loops=1)
 Planning time: 0.080 ms
 Execution time: 0.049 ms
(6 rows)




EXPLAIN ANALYZE SELECT COUNT(bidder_id) AS max_bid FROM bids
  GROUP BY bidder_id
  ORDER BY max_bid DESC
  LIMIT 1;

                                                  QUERY PLAN
---------------------------------------------------------------------------------------------------------------------
 Limit  (cost=35.65..35.65 rows=1 width=4) (actual time=0.105..0.106 rows=1 loops=1)
   ->  Sort  (cost=35.65..36.15 rows=200 width=4) (actual time=0.103..0.103 rows=1 loops=1)
         Sort Key: (count(bidder_id)) DESC
         Sort Method: top-N heapsort  Memory: 25kB
         ->  HashAggregate  (cost=32.65..34.65 rows=200 width=4) (actual time=0.047..0.051 rows=6 loops=1)
               Group Key: bidder_id
               ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.006..0.015 rows=26 loops=1)
 Planning time: 0.168 ms
 Execution time: 0.171 ms
(9 rows)



Query Type 	        Planing Time 	Execution Time 	Total Costs
Subquery 	          0.096 ms 	    0.0164 ms     	37.16
ORDER BY and LIMIT 	1.621 ms    	1.486 ms 	      35.65

-- Further Exploration

-- We mentioned earlier that using a scalar subquery was faster than
-- using an equivalent JOIN clause. Determining that JOIN statement
-- was part of the "Further Exploration" for that exercise. For this
-- "Further Exploration", compare the times and costs of those two
-- statements. The SQL statement that uses a scalar subquery is listed
-- below.

-- Scalar Subquery:

-- SELECT name,
-- (SELECT COUNT(item_id) FROM bids WHERE item_id = items.id)
-- FROM items;

EXPLAIN ANALYZE SELECT name,
(SELECT COUNT(item_id) FROM bids WHERE item_id = items.id)
FROM items;


-------------------------------------------------------------------------------------------------------------
 Seq Scan on items  (cost=0.00..25455.20 rows=880 width=36) (actual time=0.016..0.040 rows=6 loops=1)
   SubPlan 1
     ->  Aggregate  (cost=28.89..28.91 rows=1 width=4) (actual time=0.005..0.006 rows=1 loops=6)
           ->  Seq Scan on bids  (cost=0.00..28.88 rows=8 width=4) (actual time=0.002..0.003 rows=4 loops=6)
                 Filter: (item_id = items.id)
                 Rows Removed by Filter: 22
 Planning time: 0.167 ms
 Execution time: 0.069 ms
(8 rows)

EXPLAIN ANALYZE SELECT items.name,
       count(bids.item_id)
  FROM items
  LEFT OUTER JOIN bids ON bids.item_id = items.id
  GROUP BY items.name;

                                                     QUERY PLAN
---------------------------------------------------------------------------------------------------------------------
 HashAggregate  (cost=83.21..85.21 rows=200 width=36) (actual time=0.074..0.075 rows=6 loops=1)
   Group Key: items.name
   ->  Hash Right Join  (cost=29.80..75.66 rows=1510 width=36) (actual time=0.040..0.063 rows=27 loops=1)
         Hash Cond: (bids.item_id = items.id)
         ->  Seq Scan on bids  (cost=0.00..25.10 rows=1510 width=4) (actual time=0.001..0.001 rows=26 loops=1)
         ->  Hash  (cost=18.80..18.80 rows=880 width=36) (actual time=0.031..0.031 rows=6 loops=1)
               Buckets: 1024  Batches: 1  Memory Usage: 9kB
               ->  Seq Scan on items  (cost=0.00..18.80 rows=880 width=36) (actual time=0.010..0.013 rows=6 loops=1)
 Planning time: 0.247 ms
 Execution time: 0.149 ms
(10 rows)

```
Query Type  Planing Time 	Execution Time 	Total Costs
Scalar 	    0.167 ms      0.069 ms         25455.20
Join     	  0.247 ms      0.149 ms            85.21--
