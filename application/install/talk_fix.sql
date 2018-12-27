ALTER TABLE `prefix_talk_response` CHANGE `id` `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT;

ALTER TABLE `prefix_talk_response` ADD `state` VARCHAR(20) NOT NULL AFTER `text`;

ALTER TABLE `prefix_talk_proposal` DROP `type`;
ALTER TABLE `prefix_talk_proposal` ADD `state` VARCHAR(20) NOT NULL AFTER `text`, ADD INDEX (`state`);
ALTER TABLE `prefix_talk_proposal` CHANGE `id` `id` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT;