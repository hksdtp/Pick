# 🚀 Hướng dẫn Setup Supabase cho Pickleball Incanto Club

## ✅ Thông tin đã cấu hình:

- **Project ID**: `sevuymqauqrvsszyukbn`
- **URL**: `https://sevuymqauqrvsszyukbn.supabase.co`
- **Anon Key**: `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...` ✅
- **Publishable Key**: `sb_publishable_j53XnLD-CAlKIzego0WA0g_V7Raagrl`
- **Secret Key**: `sb_secret_OOu1O_pFAyzZ6vvGysKBRw_xv4zdEEq`

## 📋 Các bước setup:

### Bước 1: Truy cập Supabase Dashboard
1. Đi tới: https://supabase.com/dashboard/project/sevuymqauqrvsszyukbn
2. Đăng nhập vào tài khoản Supabase của bạn

### Bước 2: Chạy SQL Setup Script
1. Vào **SQL Editor** trong dashboard
2. Copy toàn bộ nội dung file `supabase_setup.sql`
3. Paste vào SQL Editor và nhấn **Run**

### Bước 3: Kiểm tra Tables đã tạo
Sau khi chạy script, bạn sẽ có các bảng:
- ✅ `players` - Thông tin người chơi
- ✅ `match_history` - Lịch sử trận đấu  
- ✅ `expenses` - Chi phí câu lạc bộ
- ✅ `team_combinations` - Ma trận đội
- ✅ `opponent_combinations` - Ma trận đối thủ
- ✅ `player_rankings` - View xếp hạng

### Bước 4: Test kết nối
1. Mở ứng dụng web: http://localhost:8000
2. Vào tab **Xếp Hạng**
3. Nhấn nút **"Lưu Supabase"**
4. Kiểm tra thông báo thành công

## 🎯 Tính năng đã tích hợp:

### 📊 Auto-sync:
- ✅ Tự động lưu sau mỗi trận đấu
- ✅ Đồng bộ điểm số và thống kê
- ✅ Lưu lịch sử trận đấu

### 🔄 Manual sync:
- ✅ Nút "Lưu Supabase" trong tab Xếp Hạng
- ✅ Tải dữ liệu từ cloud khi khởi động
- ✅ Backup và restore dữ liệu

### 📈 Real-time data:
- ✅ Cập nhật ngay lập tức
- ✅ Đồng bộ giữa nhiều thiết bị
- ✅ Lưu trữ an toàn trên cloud

## 🛠️ Troubleshooting:

### Lỗi kết nối:
- Kiểm tra URL và Anon Key
- Đảm bảo project đang active
- Check network connection

### Lỗi SQL:
- Chạy lại script setup
- Kiểm tra permissions
- Xem logs trong dashboard

### Lỗi sync:
- Refresh trang web
- Kiểm tra console logs
- Thử sync thủ công

## 📱 Cách sử dụng:

1. **Khởi động**: Ứng dụng tự động tải dữ liệu từ Supabase
2. **Chơi game**: Tạo đội, chơi, nhập kết quả
3. **Auto-save**: Dữ liệu tự động lưu sau mỗi trận
4. **Backup**: Nhấn "Lưu Supabase" để backup thủ công

## 🎮 Demo Data:

Script đã tạo sẵn 10 người chơi với điểm 0:
- Chị Hạnh, Thảo, Hương, Chị Huyền, Tính
- Ninh, Linh, Mạnh, Việt Anh, Duy

## 🔐 Security:

- ✅ RLS (Row Level Security) ready
- ✅ Anon key chỉ cho phép read/write cơ bản
- ✅ Secret key được bảo mật
- ✅ HTTPS encryption

## 📊 Monitoring:

Trong Supabase Dashboard có thể xem:
- 📈 Usage statistics
- 🔍 Query logs
- ⚡ Performance metrics
- 🛡️ Security events

---

**🎾 Chúc bạn chơi Pickleball vui vẻ với hệ thống quản lý chuyên nghiệp!**
