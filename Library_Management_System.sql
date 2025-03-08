create database Library_Mgt_DB;
drop database Library_Mgt_DB;
use Library_Mgt_DB;
select database();

#create table - Publisher
create table Publisher
                     (name varchar(40),
                     address varchar(30),
                     phone int);
show tables;
desc table publisher; 

#add primary key constraint
alter table Publisher
add primary key(name);
desc Publisher;

#changing datatype of attribute 
alter table Publisher
change phone phone bigint;


#add not null constraint on phone
alter table Publisher
change phone phone bigint not null;

#add not null constraint on address 
alter table Publisher
change address address varchar(30) not null;   
desc Publisher;
insert into Publisher values ('Mcgraw-Hill', 'Bangalore', 9989076587);
insert into Publisher values ('Pearson', 'NewDelhi', 9889076565);
insert into Publisher values ('Random House', 'Hyderabad', 7455679345);
insert into Publisher values ('Hachette Livre', 'Chennai', 8970862340);
insert into Publisher values ('Grupo Planeta', 'Bangalore', 7756120238);
insert into Publisher values ('Wiley India', 'New Delhi', 01143630000);
insert into Publisher values ('S Chand', 'Noida', 7291975264);
insert into Publisher values ('Technical Publications', 'Pune', 9763719464);
insert into Publisher values ('Nirali Prakashan', 'Pune', 02025512336);
insert into Publisher values ('Prakash Publication', 'Jalgaon', 9272514482);
insert into Publisher values ('Galgotia Publications', 'New Delhi', 01123263334);#error
select * from Publisher;

#Qurie1 - list the name of all publishers
select name from Publisher;

#Qurie2-list the name of all publisher along with contact no
select name,phone from Publisher;

#qurie3-list the name of all publisher from new delhi
select name 
from Publisher
where address='New Delhi';

#querie4-convert NewDelhi to New Delhi
update Publisher
set address ='New Delhi'
where name='Pearson';

#6-use of order clause
select * from publisher
order by name asc;

#create table- book
create table Book
                 (book_id int primary key,
                 title varchar(40),
                 pub_year varchar(20),
                 publisher_name varchar(40));
show tables;
drop table book;
desc table Book;

#add referntial integrity constraint(i.e.foreign key constraint)
alter table Book
add foreign key(publisher_name)references publisher(name) on delete cascade;
desc Book; 

insert into book values (1,'DBMS','2017', 'Mcgraw-Hill');
insert into book values (2,'ADBMS','2016', 'Mcgraw-Hill');
insert into book values (3,'CN','2016', 'Pearson');
insert into book values (4,'CG','2015', 'Grupo Planeta');
insert into book values (5,'OS','2016', 'Pearson');
insert into book values (6,'CO','2008', 'Nirali Prakashan');
insert into book values (7,'CO','2005', 'Galgotia Publications');
insert into book values (8,'DBMS','2022', 'Technical Publications');
insert into book values (9,'DBMS for Distributed System','2022', 'Pearson');
insert into book values (10,' Recent Trends in DBMS','2022', 'Vasant');#error
select * from book;

#querie 5-list the unique titles of books published by publisher
select distinct title from book;

#6-use of order by clause
select * from book
order by title desc;

#7-find the latest publication year for DBMS book
select pub_year 
from book
where title='DBMS' 
order by pub_year desc
limit 1;

#8-list the title of book & publication year published between 2015 and 2022.Display recent publication years on top.alter
select title,pub_year
from book
where pub_year between 2015 and 2022
order by pub_year desc;

 #create table - book athours
 create table Book_Authors
                         (book_id int,
                         author_name varchar(30),
                         primary key(book_id,author_name),
                         foreign key(book_id)references book (book_id)on delete cascade);
  show tables;    
  desc Book_Authors;
  insert into book_authors values (1, 'Navathe');
insert into book_authors values (2, 'Navathe');
insert into book_authors values (3, 'Tanenbaum');
insert into book_authors values (4, 'Edward Angel');
insert into book_authors values (5, 'Galvin');
insert into book_authors values (6, 'K. P. Adhiya');
insert into book_authors values (7, 'Navin Kumar');
insert into book_authors values (8, 'A. A. Puntambekar');
select * from book_authors;

  
  #create table -Library_Branch
  create table Library_Branch
                 (branch_id int primary key,
                 branch_name varchar(40),
                 address varchar(30));
  drop table  Library_Branch;              
   show tables;
   desc table Library_Branch;
   insert into library_branch values (10,'RR Nagar','Bangalore');
insert into library_branch values (11,'RNSIT','Bangalore');
insert into library_branch values (12,'Rajaji Nagar', 'Bangalore');
insert into library_branch values (13,'NITTE','Mangalore');
insert into library_branch values (14,'Manipal','Udupi');
insert into library_branch values (15,'SSBT','Jalgaon');
insert into library_branch values (16,'SPIT','Mumbai');
select * from library_branch;
   
   #add unique constraint and not null simultaneously for branch name
   alter table Library_Branch
   change branch_name branch_name varchar(40) not null unique; 
   desc Library_Branch;
   
   #create table Book_Copies
   create table Book_Copies
                          (book_id int,
                          branch_id int,
                          no_of_copies int,
                          primary key(book_id,branch_id),
                          foreign key(book_id)references book(book_id)on delete cascade,
                          foreign key(branch_id)references library_branch(branch_id)on delete cascade);
 show tables;
 desc Book_Copies;
 insert into book_copies values (1, 10, 10);
insert into book_copies values (1, 11, 5);
insert into book_copies values (2, 12, 2);
insert into book_copies values (2, 13, 5);
insert into book_copies values (3, 14, 7);
insert into book_copies values (5, 10, 1);
insert into book_copies values (4, 11, 3);
insert into book_copies values (6, 15, 13);
insert into book_copies values (6, 16, 10);
select * from book_copies;
 
 #add check constraint
 alter table Book_Copies
 add check(no_of_copies>0);
 
 #create the table_card
 create table Card
                 (card_no int primary key);
  show tables;
  desc Card;
  insert into card values (100);
insert into card values (101);
insert into card values (102);
insert into card values (103);
insert into card values (104);
insert into card values (105);
select * from card;

  
  #create table Book_Lending
  create table Book_Lending
                     (book_id int,
                     branch_id int,
                     card_no int not null,
                     date_out date,
                     due_date date,
                     primary key(book_id,branch_id,card_no),
                     foreign key(book_id)references book(book_id)on delete cascade,
                     foreign key(branch_id)references Library_Branch(branch_id)on delete cascade);
  show tables;
  desc Book_Lending;
  insert into book_lending values (1, 10, 101, '2017-01-10', '2017-06-17'); 
insert into book_lending values (3, 14, 101, '2017-03-18', '2017-07-17'); 
insert into book_lending values (2, 13, 101, '2017-02-11', '2017-04-21'); 
insert into book_lending values (4, 11, 101, '2017-03-15', '2017-07-15'); 
insert into book_lending values (1, 11, 104, '2017-04-12', '2017-05-12');
select * from book_lending;

#querie9.display title ,publication year and publisher name for all titles which includes 'DBMS'
select title,pub_year,publisher_name
from book
where title like '%DBMS%';

#querie10.list the details of publisher belonging to pune or jalgaon
select *
from publisher
where address='Pune'or address='Jalgaon';

select *
from publisher
where address in('Pune','Jalgaon');

#querie11.list the details of publishers who dont belong to pune or jalgaon use of IS NULL
select *
from publisher
where address not in('Pune','Jalgaon');

#use IS NULL
select *
from publisher
where phone is null;

select *
from publisher
where phone is not null;

#querie12.to delete the records
select * from book_copies;

delete from book_copies
where (book_id=1 and branch_id=10)
	or (book_id=1 and branch_id=11)
	or(book_id=2 and branch_id=12);
select * from book_copies;

insert into book_copies values (1, 10, 10);
insert into book_copies values (1, 11, 5);
insert into book_copies values (2, 12, 2);
select * from book_copies;
      
#querie13.display total no. of copies of all books
select sum(no_of_copies) as total_copies_of_all_books
from book_copies;

#14.display average no. of copies of each book with its ID
select book_id,avg(no_of_copies) as Average_No_Of_Copies_Of_Each_Book
from book_copies
group by book_id;

#15.display-average no. of copies of each books,its ID,name of author and title of book

#select Book_Copies.book_id, author_name, title, avg(no_of_copies) as Average_No_of_Copies_Per_Book
#from Book_Copies, Book_Authors, Book
#where Book_Copies.book_id = Book_Authors.book_id and Book.book_id = Book_Authors.book_id 
#group by book_id;

select book_copies.book_id,author_name,title,avg(no_of_copies)as Avg_No_Of_Copies_Of_Each_Book
from book_copies,book_authors,book
where book_copies.book_id=book_authors.book_id and book.book_id=book_authors.book_id
group by book_id,author_name,title;

select book_copies.book_id,author_name,title,avg(no_of_copies)as Avg_No_Of_Copies_Of_Each_Book
from book_copies join book_authors join book
on book_copies.book_id=book_authors.book_id and book.book_id=book_authors.book_id
group by book_id;

select * from book_copies;
select * from book_authors;
select * from book;

#16.find out authors whose average no. of books in library are more than 3 and display the name of author on top having maximum  average no. of books copies
select book_copies.book_id,author_name,title ,avg(no_of_copies) as avg_no_of_copies_per_book
from book_copies,book_authors,book
where book_copies.book_id=book_authors.book_id and book.book_id=book_authors.book_id
group by book_id,author_name,title
having avg_no_of_copies_per_book>3
order by avg_no_of_copies_per_book desc;

use Library_Mgt_DB;
select database();

#1.find out total no. of publishers
select count(name) as Total_No_Publisher
from publisher;

#2.find out authors name who wrote maximum books
select author_name ,count(author_name) as no_of_books_written
from book_authors
group by author_name
order by no_of_books_written desc
limit 1;

#3.display publishers name from new delhi and pune city using union operator 
select name 
from publisher 
where address='New Delhi'
union
select name 
from publisher 
where address='Pune';

select name ,address
from publisher 
where address='New Delhi'
union  all
select name ,address
from publisher 
where address='Pune';

#4.retreive deatails of all books in the library-id,title,name of publisher,author,no. of copies in each branch,etc
select book.book_id,title,publisher_name,author_name,no_of_copies,book_copies.branch_id,branch_name
from book,book_authors,book_copies,library_branch
where book.book_id=book_authors.book_id and book_authors.book_id=book_copies.book_id and book_copies.branch_id=library_branch.branch_id
order by book.book_id;

#5.get the particulars of borrowers who have borrowed more than 3 books from jan 2017 to june 2017
select card_no
from book_lending
where date_out between '2017-01-01' and '2017-07-01'
group by card_no
having count(card_no)>3;

#? 6.get all the particulars (card_no,book_id,title of books) of borrowers who have borrowed book from 12th april to 12th may 2017
select card_no,book.book_id,title
from book,book_lending
where (date_out between'2017-04-12'and'2017-05-12')
      and book.book_id=book_lending.book_id
group by card_no
having count(card_no)>0;
      
#7.list all library branch names from banglore and jalgaon
select branch_name,address
from library_branch
where address='Bangalore'or address='Jalgaon';

select branch_name,address
from library_branch
where address in('Bangalore','Jalgaon');

select branch_name,address
from library_branch
where address not in('Bangalore','Jalgaon');

#8.list all library names except from banglore and jalgaon 
select branch_name,address
from library_branch
where address='Bangalore' and address='Jalgaon';

#from library_branch
#where address='%';

#9.list the title of those books who dont have any author
select title
from book left join book_authors
on book.book_id=book_authors.book_id
where book_authors.author_name is null;

#right join
select title
from book_authors right join book
on book.book_id=book_authors.book_id
where book_authors.author_name is null;

#10.how many copies of the book titled as CO are owned by SSBT library branch 

               #********
# Use of full join concept
select title
from book left join book_authors
on book.book_id = book_authors.book_id
where book_authors.author_name is null
union
select title
from book_authors right join book
on book.book_id = book_authors.book_id
where book_authors.author_name is null;


# How many copies of the book titled 'CO' are owned by the library branch whose name is "SSBT"?
select no_of_copies as No_of_Copies_of_CO_at_SSBT
from book, library_branch, book_copies
where book.book_id = book_copies.book_id and  library_branch.branch_id = book_copies.branch_id
and branch_name ='SSBT' and title = 'CO';


# Trigger 
# If number of copies of any book purchased for any branch is more than 10,
# then as a discount, branch receives one more additional copy. For more than 20,
# additional 2 copies and son on. (i.e. one more additional copy per 10 books)

show triggers;
select * from book_copies;
insert into book_copies values(3, 15, 11);
select * from book_copies;   
insert into book_copies values(3, 16, 17);
select * from book_copies;  
insert into book_copies values(3, 13, 21);
select * from book_copies;    

delete from book_copies    
where (book_id=3 and branch_id=15)
or (book_id=3 and branch_id=16)
or (book_id=3 and branch_id=13);
select * from book_copies; 

drop trigger trigger_befor_insert_Lib_Mgt;
show triggers;

# View
# To create a view for students - To display his/her card number, book id & book title 
# against his/her name, branch id & branch name from where book is issued and due 
# date.

create view View_for_Student_Lib_Mgt as
select card_no, book_lending.book_id, title, book_lending.branch_id, branch_name, due_date
from book_lending, book, library_branch
where book_lending.branch_id = library_branch.branch_id and
book_lending.book_id = book.book_id;

show full tables;
select * from View_for_Student_Lib_Mgt;

select * 
from View_for_Student_Lib_Mgt
where card_no=104;

select * from book_lending;

# Update a View
update View_for_Student_Lib_Mgt
set due_date = '2017-07-12'
where card_no = 104;

select * 
from View_for_Student_Lib_Mgt
where card_no=104;

select * from book_lending
where card_no=104;

update View_for_Student_Lib_Mgt
set due_date = '2017-05-12'
where card_no = 104;

select * 
from View_for_Student_Lib_Mgt
where card_no=104;

select * from book_lending
where card_no=104;

# delete a View
drop view View_for_Student_Lib_Mgt;
show full tables;

# Function
# The functions is used to display number of publishers from a particular city

delimiter $$              
create function publisher_count(publisher_address varchar(30))
	returns integer
    deterministic
    begin 
	    declare p_count integer;
		select count(*) into p_count
		from publisher
		where publisher.address = publisher_address;
	return p_count;
    end 
$$    
delimiter ;   

show function status; 
select publisher_count('New Delhi') as Publisher_Count;  
select publisher_count('NewDelhi') as Publisher_Count;
select publisher_count('Bangalore') as Publisher_Count;

drop function publisher_count;
show function status;

use library_mgt_db;
select book_id,avg(no_of_copies) as average_no_of_copies_per_book
from book_copies
group by book_id;


# Procedure
# To define the procedure that returns the count of publishers

delimiter $$
create procedure publisher_count_procedure(in publisher_address varchar(30), out p_count int)
	begin 
		select count(*) into p_count
		from publisher
        where publisher.address = publisher_address;
	end $$
delimiter ;

show procedure status;

# now call the procedure
call publisher_count_procedure('New Delhi', @p_count);
select @p_count as Publisher_Count;
call publisher_count_procedure('NewDelhi', @p_count);
select @p_count as Publisher_Count;
call publisher_count_procedure('Bangalore', @pub_count);
select @pub_count as Publisher_Count;

drop procedure publisher_count_procedure;
show procedure status;


use Library_Mgt_DB;
select database();

delimiter $$
create trigger before_insert_lib_mgt before insert 
on book_copies for each row
begin 
set  new.no_of_copies=new.no_of_copies+floor(new.no_of_copies*0.10);
end $$
 delimiter ;

show triggers; 
select * from book_copies;
