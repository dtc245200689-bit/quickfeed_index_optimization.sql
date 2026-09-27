-- Đảm bảo sử dụng đúng cơ sở dữ liệu dự án (Giả định tên là quickfeed_db)
CREATE DATABASE IF NOT EXISTS quickfeed_db;
USE quickfeed_db;

-- =========================================================================
-- BƯỚC 1: KIỂM TRA KÍCH THƯỚC STORAGE TRƯỚC KHI TỐI ƯU
-- =========================================================================
SELECT 
    table_name AS 'Table',
    ROUND(((data_length) / 1024 / 1024), 2) AS 'Data Size (MB)',
    ROUND(((index_length) / 1024 / 1024), 2) AS 'Index Size (MB)',
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Total Size (MB)'
FROM information_schema.TABLES
WHERE table_schema = 'quickfeed_db' AND table_name = 'posts';


-- =========================================================================
-- BƯỚC 2: TIẾN HÀNH DROP 3 INDEX VI PHẠM (HIỆU NĂNG THẤP / TỐN KHÔNG GIAN)
-- =========================================================================
ALTER TABLE posts DROP INDEX idx_content;
ALTER TABLE posts DROP INDEX idx_post_type;
ALTER TABLE posts DROP INDEX idx_is_visible;

-- LƯU Ý: Giữ lại đúng 2 Index có giá trị tra cứu cao: idx_user_id và idx_created_at
-- (Không thực thi lệnh xóa trên 2 chỉ mục này)


-- =========================================================================
-- BƯỚC 3: KIỂM TRA LẠI KÍCH THƯỚC STORAGE SAU KHI SỬA ĐỔI ĐỂ CHỨNG MINH
-- =========================================================================
SELECT 
    table_name AS 'Table',
    ROUND(((data_length) / 1024 / 1024), 2) AS 'Data Size (MB)',
    ROUND(((index_length) / 1024 / 1024), 2) AS 'Index Size (MB)',
    ROUND(((data_length + index_length) / 1024 / 1024), 2) AS 'Total Size (MB)'
FROM information_schema.TABLES
WHERE table_schema = 'quickfeed_db' AND table_name = 'posts';
