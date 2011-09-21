/*Usage: 
1 create this stored procedure in your database
2 Usage in MySQL: mysql> call sp_deduct_credit_and_money ('test','test',1,0,10.00)
3 Usage in Rails: ActiveRecord::Base.connection.execute("call sp_deduct_credit_and_money('#{title}','#{content}',#{id},#{credit},#{money})") @question_controller.rb
*/
/* Drop if Exists */
DROP PROCEDURE IF EXISTS sjobs_development.sp_deduct_credit_and_money

/* Crete Stored Procedure*/
DELIMITER //
CREATE PROCEDURE sp_deduct_credit_and_money (
	in title varchar(100),
	in content text,
	in user_id int,
	in deduct_credit int,
	in deduct_money DECIMAL(8,2))
BEGIN
Declare question_id int;
IF deduct_credit = 0 AND deduct_money =0.00 THEN
	START TRANSACTION;
 	/* Create a new question */
	INSERT INTO questions (answers_count, content, correct_answer_id, created_at, credit, money, title, updated_at, user_id, votes_count) VALUES (0, content, 0, NOW(), deduct_credit, deduct_money, title, NOW(), user_id, 0);
	
	/* update user info*/
	UPDATE users
   		SET questions_count = COALESCE(questions_count, 0) + 1,
					  updated_at = NOW(), 
					  credit = credit - deduct_credit
 	  WHERE users.id = user_id;
	
	COMMIT;
ELSE IF deduct_credit > 0 AND deduct_money =0.00 THEN
	START TRANSACTION;
 	/* Create a new question */
	INSERT INTO questions (answers_count, content, correct_answer_id, created_at, credit, money, title, 
	updated_at, user_id, votes_count) 
	VALUES (0, content, 0, NOW(), deduct_credit, deduct_money, title, NOW(), user_id, 0);

	/* Get new question id*/
	select id into @question_id from questions order by id desc limit 1;
	
	/* update user info*/
	UPDATE users
   		SET questions_count = COALESCE(questions_count, 0) + 1,
			 updated_at = NOW(), 
			 credit = credit - deduct_credit
 	  WHERE users.id = user_id;

	/*insert into tran*/
	INSERT INTO credit_transactions (answer_id, created_at, payment, question_id, trade_status, trade_type, 	updated_at, user_id, value, winner_id) 
	VALUES (NULL, NOW(), 1, @question_id, 0, 0, NOW(), user_id, deduct_credit, NULL);
	
	COMMIT;
ELSE IF deduct_credit = 0 AND deduct_money > 0.00 THEN
	START TRANSACTION;
 	/* Create a new question */
	INSERT INTO questions (answers_count, content, correct_answer_id, created_at, credit, money, title, 
	updated_at, user_id, votes_count) 
	VALUES (0, content, 0, NOW(), deduct_credit, deduct_money, title, NOW(), user_id, 0);

	/* Get new question id*/
	select id into @question_id from questions order by id desc limit 1;

	/* update user info*/
	UPDATE users
   		SET questions_count = COALESCE(questions_count, 0) + 1,
					  updated_at = NOW(), 
					  money = money - deduct_money
 	  WHERE users.id = user_id;

	/*insert into tran*/
	INSERT INTO money_transactions (answer_id, created_at, payment, question_id, trade_status, 
	trade_type, updated_at, user_id, value, winner_id) 
	VALUES (NULL, now(), 1, @question_id, 0, 0, now(), user_id, deduct_money, NULL);
	
	COMMIT;
ELSE IF deduct_credit > 0 AND deduct_money > 0.00 THEN
	START TRANSACTION;
 	/* Create a new question */
	INSERT INTO questions (answers_count, content, correct_answer_id, created_at, credit, money, title, 	updated_at, user_id, votes_count) 
	VALUES (0, content, 0, NOW(), deduct_credit, deduct_money, title, NOW(), user_id, 0);

	/* Get new question id*/
	select id into @question_id from questions order by id desc limit 1;

	/* update user info*/
	UPDATE users
   		SET questions_count = COALESCE(questions_count, 0) + 1,
					  updated_at = NOW(), 
					  credit = credit - deduct_credit,
					  money = money - deduct_money
 	  WHERE users.id = user_id;

	/*insert into tran*/
	INSERT INTO credit_transactions (answer_id, created_at, payment, question_id, trade_status, trade_type, 	updated_at, user_id, value, winner_id) 
	VALUES (NULL, NOW(), 1, @question_id, 0, 0, NOW(), user_id, deduct_credit, NULL);
	
	INSERT INTO money_transactions (answer_id, created_at, payment, question_id, trade_status, 
	trade_type, updated_at, user_id, value, winner_id) 
	VALUES (NULL, now(), 1, @question_id, 0, 0, now(), user_id, deduct_money, NULL);
	
	COMMIT;
end if;
end if;
end if;
end if;
END