ALTER TABLE `prefix_talk_response` CHANGE `id` `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `prefix_talk_response` ADD `state` VARCHAR(20) NOT NULL AFTER `text`;
