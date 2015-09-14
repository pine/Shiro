CREATE TABLE IF NOT EXISTS `qiita_item` (
  `id`        INTEGER UNSIGNED AUTO_INCREMENT,
  `item_id`   VARCHAR(255)     NOT NULL,
  `notice_id` VARCHAR(255)     NOT NULL,
  PRIMARY KEY (`id`)
);
