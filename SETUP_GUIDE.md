# 🚀 Hướng dẫn Setup Hoàn chỉnh - Pickleball Incanto Club

## 📋 **Các bước setup theo thứ tự:**

### **Bước 1: Setup Database Tables**
1. Vào Supabase Dashboard: https://supabase.com/dashboard/project/sevuymqauqrvsszyukbn
2. Chọn **SQL Editor** 
3. Chạy file: `create_transactions_table.sql`
4. Kiểm tra các bảng đã tạo:
   - ✅ `transactions` - Giao dịch thu chi
   - ✅ `penalties` - Danh sách phạt
   - ✅ `players` - Thành viên (đã có)
   - ✅ `expenses` - Chi phí (đã có)

### **Bước 2: Setup Storage cho Upload Ảnh**
1. Vào **Storage** trong Supabase Dashboard
2. Chạy file: `setup_storage.sql` trong SQL Editor
3. Hoặc tạo thủ công:
   - **Create bucket**: Tên `receipts`, Public = true
   - **Add policies**: Allow public read/write

### **Bước 3: Kiểm tra Kết nối**
1. Mở app: http://localhost:8000
2. Test các tính năng:
   - ✅ Xem giao dịch (tab Chi phí)
   - ✅ Thêm giao dịch mới
   - ✅ Upload ảnh hóa đơn
   - ✅ Reset danh sách phạt

## 🔧 **Sửa lỗi thường gặp:**

### **Lỗi Storage 403 Unauthorized:**
```
Error uploading receipt: {statusCode: '403', error: 'Unauthorized'}
```
**Giải pháp:**
1. Vào **Storage** → **Policies**
2. Thêm policy cho bucket `receipts`:
   ```sql
   CREATE POLICY "Allow public upload on receipts" 
   ON storage.objects FOR INSERT 
   WITH CHECK (bucket_id = 'receipts');
   ```

### **Lỗi Cannot set properties of null:**
```
TypeError: Cannot set properties of null (setting 'innerHTML')
```
**Giải pháp:** Đã fix trong code - kiểm tra element tồn tại

### **Lỗi Datetime format:**
```
The specified value does not conform to the required format
```
**Giải pháp:** Đã fix - convert datetime sang format đúng

## 🎯 **Tính năng đã hoàn thành:**

### **💰 Quản lý Giao dịch:**
- ✅ Đồng bộ 2 chiều với Supabase
- ✅ Upload nhiều ảnh hóa đơn
- ✅ Xem ảnh fullscreen
- ✅ CRUD operations hoàn chỉnh

### **🚫 Quản lý Phạt:**
- ✅ Danh sách chưa thanh toán
- ✅ Checkbox đánh dấu từng người
- ✅ Nút Reset toàn bộ
- ✅ Tự động cộng tiền vào quỹ

### **🔐 Bảo mật:**
- ✅ Mật khẩu admin "111"
- ✅ Xác nhận trước khi xóa/reset
- ✅ Row Level Security policies

## 📱 **Demo Flow hoàn chỉnh:**

### **Thêm giao dịch có ảnh:**
1. Tab "Chi phí" → Nút ➕
2. Nhập mật khẩu "111"
3. Điền thông tin + Upload ảnh
4. Lưu → Tự động sync database

### **Reset danh sách phạt:**
1. Tab "Chi phí" → Scroll xuống "Quỹ Phạt"
2. Nút "Reset" → Mật khẩu "111"
3. Xác nhận → Tiền phạt cộng vào quỹ

### **Xem chi tiết giao dịch:**
1. Click vào giao dịch bất kỳ
2. Xem thông tin + ảnh hóa đơn
3. Click ảnh để xem fullscreen

## 🛠️ **Troubleshooting:**

### **Nếu vẫn lỗi Storage:**
1. Tạo bucket thủ công:
   - Vào Storage → New bucket
   - Name: `receipts`
   - Public: ✅ Enabled
2. Thêm policies thủ công trong SQL Editor

### **Nếu thiếu bảng:**
1. Chạy lại file SQL setup
2. Kiểm tra permissions
3. Xem logs trong Dashboard

### **Nếu app không load:**
1. Check console errors (F12)
2. Verify Supabase URL/Key
3. Test network connection

## 🎮 **Sẵn sàng sử dụng!**

App đã hoàn thiện với:
- 💾 Database sync real-time
- 📸 Upload ảnh lên cloud
- 💰 Quản lý tài chính đầy đủ
- 🔒 Bảo mật admin
- 📱 UI/UX như native app

Mọi thứ đã sẵn sàng cho câu lạc bộ! 🏓
