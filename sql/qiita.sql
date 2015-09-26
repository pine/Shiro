CREATE TABLE `qiita_item` (
  `id`        INTEGER UNSIGNED AUTO_INCREMENT,
  `item_id`   VARCHAR(255)     NOT NULL,
  `notice_id` VARCHAR(255)     NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE UNIQUE INDEX `qiita_item_item_id_notice_id_uniq_idx`
  ON `qiita_item` (`item_id`, `notice_id`);
