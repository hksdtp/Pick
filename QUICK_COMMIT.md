# 🚀 Quick Commit Instructions

## 📍 **Bước 1: Mở Terminal trong project**

1. **Finder** → Tìm thư mục project "Pick"
2. **Right-click** → "Services" → "New Terminal at Folder"
3. Hoặc **Terminal** → `cd /path/to/your/Pick/project`

## ⚡ **Bước 2: Chạy 1 trong 2 cách**

### **Cách 1: Chạy script tự động**
```bash
chmod +x commit_and_push.sh
./commit_and_push.sh
```

### **Cách 2: Commands thủ công**
```bash
# Initialize git (if needed)
git init
git remote add origin https://github.com/hksdtp/Pick.git

# Add and commit
git add .
git commit -m "feat: mobile-optimized UI with collapsible transaction history

- Add collapsible transaction history with summary
- Remove duplicate penalty section  
- Sync design system variables
- Improve mobile UX with touch-friendly interactions"

# Push to GitHub
git push origin main
```

## 🎯 **Kết quả mong đợi:**

```
✅ Enumerating objects: 25, done.
✅ Counting objects: 100% (25/25), done.
✅ Delta compression using up to 8 threads
✅ Compressing objects: 100% (20/20), done.
✅ Writing objects: 100% (25/25), 15.2 KiB | 2.5 MiB/s, done.
✅ Total 25 (delta 12), reused 0 (delta 0)
To https://github.com/hksdtp/Pick.git
   abc1234..def5678  main -> main
```

## 🔗 **Sau khi push thành công:**

- **GitHub**: https://github.com/hksdtp/Pick
- **Live app**: Có thể deploy qua GitHub Pages
- **Mobile test**: Mở trên điện thoại để test

## 🏓 **App features đã hoàn thành:**

✅ **Mobile-optimized transaction history**
✅ **Collapsible UI for space saving**  
✅ **Consistent design system**
✅ **Touch-friendly interactions**
✅ **Smooth animations**
✅ **Clean, professional UI**

**Perfect pickleball club management app! 🎉**
