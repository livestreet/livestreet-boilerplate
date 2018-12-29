ALTER TABLE `prefix_talk_message` 
ADD `state` VARCHAR(20) NOT NULL AFTER `text`, 
ADD `rating` FLOAT NOT NULL AFTER `state`, 
ADD INDEX (`state`), 
ADD INDEX (`rating`);

ALTER TABLE `prefix_talk_message` CHANGE `id` `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `prefix_talk_message` ADD `target_type` VARCHAR(20) NOT NULL AFTER `user_id`, ADD INDEX (`target_type`);