DROP DATABASE IF EXISTS Exp7DB;
CREATE DATABASE Exp7DB;
USE Exp7DB;

CREATE TABLE DEPT (
    deptno INT PRIMARY KEY,
    dname  VARCHAR(20),
    loc    VARCHAR(20)
);

CREATE TABLE EMP (
    empno    INT PRIMARY KEY,
    ename    VARCHAR(20),
    job      VARCHAR(20),
    mgr      INT,
    hiredate DATE,
    sal      DECIMAL(8,2),
    comm     DECIMAL(8,2),
    deptno   INT,
    FOREIGN KEY (mgr)    REFERENCES EMP(empno),
    FOREIGN KEY (deptno) REFERENCES DEPT(deptno)
);

CREATE TABLE SALGRADE (
    grade INT PRIMARY KEY,
    losal DECIMAL(8,2),
    hisal DECIMAL(8,2)
);

CREATE TABLE AREAS (
    areaid   INT PRIMARY KEY,
    areaname VARCHAR(30),
    city     VARCHAR(20),
    pincode  VARCHAR(6)
);

INSERT INTO DEPT VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH',   'DALLAS'),
(30, 'SALES',      'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');

INSERT INTO EMP VALUES
(7839, 'KING',   'PRESIDENT', NULL, '2015-11-17', 5000, NULL, 10),
(7566, 'JONES',  'MANAGER',   7839, '2016-04-02', 2975, NULL, 20),
(7698, 'BLAKE',  'MANAGER',   7839, '2016-05-01', 2850, NULL, 30),
(7782, 'CLARK',  'MANAGER',   7839, '2016-06-09', 2450, NULL, 10),
(7788, 'SCOTT',  'ANALYST',   7566, '2017-04-19', 3000, NULL, 20),
(7902, 'FORD',   'ANALYST',   7566, '2017-12-03', 3000, NULL, 20),
(7499, 'ALLEN',  'SALESMAN',  7698, '2016-02-20', 1600,  300, 30),
(7521, 'WARD',   'SALESMAN',  7698, '2016-02-22', 1250,  500, 30),
(7844, 'TURNER', 'SALESMAN',  7698, '2016-09-08', 1500,    0, 30),
(7900, 'JAMES',  'CLERK',     7698, '2017-12-03',  950, NULL, 30),
(7934, 'MILLER', 'CLERK',     7782, '2018-01-23', 1300, NULL, 10),
(7999, 'ADAMS',  'CLERK',     7788, '2019-05-23', 1100, NULL, NULL);

INSERT INTO SALGRADE VALUES
(1,  700, 1200),
(2, 1201, 1400),
(3, 1401, 2000),
(4, 2001, 3000),
(5, 3001, 9999);

INSERT INTO AREAS VALUES
(1, 'Wall Street',  'NEW YORK', '100005'),
(2, 'Downtown',     'DALLAS',   '752010'),
(3, 'The Loop',     'CHICAGO',  '606010'),
(4, 'Back Bay',     'BOSTON',   '021160'),
(5, 'Sector Five',  'SEATTLE',  '981010');

SELECT * FROM DEPT;
SELECT * FROM EMP;
SELECT * FROM SALGRADE;
SELECT * FROM AREAS;

SELECT e.empno, e.ename, d.dname, d.loc
FROM   EMP e, DEPT d
WHERE  e.deptno = d.deptno;

SELECT d.dname, d.loc, a.areaname, a.pincode
FROM   DEPT d, AREAS a
WHERE  d.loc = a.city;

SELECT e.empno, e.ename, e.sal, s.grade
FROM   EMP e, SALGRADE s
WHERE  e.sal BETWEEN s.losal AND s.hisal;

SELECT e.empno, e.ename AS Employee, m.ename AS Manager
FROM   EMP e, EMP m
WHERE  e.mgr = m.empno;

SELECT e.empno, e.ename AS Employee, m.ename AS Manager
FROM   EMP e LEFT JOIN EMP m ON e.mgr = m.empno;

SELECT e.ename, d.dname
FROM   EMP e CROSS JOIN DEPT d;

SELECT COUNT(*) AS TotalCombinations FROM EMP CROSS JOIN DEPT;

SELECT e.ename, e.job, d.dname, d.loc
FROM   EMP e INNER JOIN DEPT d ON e.deptno = d.deptno;

SELECT e.ename, e.job, d.dname, d.loc
FROM   EMP e LEFT OUTER JOIN DEPT d ON e.deptno = d.deptno;

SELECT e.ename, e.job, d.dname, d.loc
FROM   EMP e RIGHT OUTER JOIN DEPT d ON e.deptno = d.deptno;

SELECT e.ename, e.job, d.dname, d.loc
FROM   EMP e LEFT JOIN DEPT d ON e.deptno = d.deptno
UNION
SELECT e.ename, e.job, d.dname, d.loc
FROM   EMP e RIGHT JOIN DEPT d ON e.deptno = d.deptno;
