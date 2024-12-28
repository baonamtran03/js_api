const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');

const login = (req, res, db) => {
    const { email, password } = req.body;

    // Kiểm tra xem email hoặc username có tồn tại trong database không
    const query = 'SELECT * FROM `user` WHERE `email` = ? OR `username` = ?';
    
    db.query(query, [email, password], (err, results) => {
        if (err) {
            return res.status(500).json({ message: 'Đã xảy ra lỗi. Vui lòng thử lại sau!' });
        }

        if (results.length === 1) {
            const user = results[0];
            // So sánh password đã mã hoá với password người dùng nhập vào, sử dụng thư viện bcrypt
            if (bcrypt.compareSync(password, user.password)) {
                const tokenPayload = {
                    username: user.username,
                    name: user.name,
                    iduser: user.iduser
                };
                // Tạo JWT token với payload là username, name và iduser
                const token = jwt.sign(tokenPayload, 'your_jwt_secret', { expiresIn: '4h' });

                // Trả về response với token và thông tin user.
                return res.json({
                    message: `Xin chào ${user.username}! Mua sắm vui vẻ!`,
                    loggedin: true,
                    token: token,
                    user: {
                        username: user.username,
                        name: user.name
                    }
                });
            } else {
                // Nếu password không khớp thì trả về lỗi
                return res.status(401).json({ message: 'Mật khẩu không đúng!' });
            }
        } else {
            // Nếu không tìm thấy email hoặc username thì trả về lỗi
            return res.status(401).json({ message: 'Thông tin không hợp lệ!' });
        }
    });
};
//dky
const signup = (req, res, db) => {
    const { name, username, email, password, address, phone } = req.body;
    // Mã hoá password bằng thư viện bcrypt
    const passwordHash = bcrypt.hashSync(password, 10);

    // Các ràng buộc dữ liệu
    const nameRegex = /^[a-zA-Z\s]+$/;
    const usernameRegex = /^[a-zA-Z][a-zA-Z0-9]*$/;
    const emailMaxLength = 70;
    const phoneMaxLength = 70;
    const addressMaxLength = 128;

    // Kiểm tra password có chứa ít nhất 1 số, 1 chữ hoa, 1 chữ thường và 1 ký tự đặc biệt
    const number = /[0-9]/.test(password);
    const uppercase = /[A-Z]/.test(password);
    const lowercase = /[a-z]/.test(password);
    const specialChars = /[^\w]/.test(password);

    let errors = [];
   
    if (!nameRegex.test(name)) {
        errors.push('Tên không hợp lệ. Vui lòng nhập tên không có ký tự đặc biệt.');
    }
    if (!usernameRegex.test(username)) {
        errors.push('Tên người dùng không hợp lệ. Nó phải bắt đầu bằng một chữ cái và chỉ có thể chứa các chữ cái và số.');
    }
    if (email.length > emailMaxLength) {
        errors.push('Email không thể vượt quá ' + emailMaxLength + ' ký tựtự.');
    }
    if (phone.length > phoneMaxLength) {
        errors.push('Số điện thoại không thể vượt quá ' + phoneMaxLength + ' ký tự.');
    }
    // Kiểm tra password có chứa ít nhất 1 số, 1 chữ hoa, 1 chữ thường và 1 ký tự đặc biệt
    if (password.length < 8 || !number || !uppercase || !lowercase || !specialChars) {
        errors.push('Mật khẩu không hợp lệ. Nó phải chứa ít nhất 8 ký tự, bao gồm một chữ hoa, một chữ thường, một số và một ký tự đặc biệt.');
    }
    if (address.length > addressMaxLength) {
        errors.push('Địa chỉ không thể vượt quá ' + addressMaxLength + ' ký tự.');
    }

    // Nếu có lỗi thì trả về lỗi vào trong response
    if (errors.length > 0) {
        return res.status(400).json({ message: errors.join('\n') });
    }

    // Kiểm tra xem email, username và phone đã tồn tại trong database chưa
    const checkQuery = 'SELECT * FROM `user` WHERE `email` = ? OR `username` = ? OR `phonenumber` = ?';
    db.query(checkQuery, [email, username, phone], (err, results) => {
        // if (err) {
        //     console.log(err);
        //     return res.status(500).json({ message: 'Đã xảy ra lỗi. Vui lòng thử lại sau!' });
        // }

        if (results.length > 0) {
            results.forEach(row => {
                if (row.email === email) {
                    errors.push('Email đã tồn tại.');
                }
                if (row.username === username) {
                    errors.push('Tên người dùng đã tồn tại.');
                }
                if (row.phonenumber === phone) {
                    errors.push('Số điện thoại đã tồn tại.');
                }
            });

            if (errors.length > 0) {
                return res.status(400).json({ message: errors.join('\n') });
            }
        }

        // Nếu không có lỗi thì thêm user vào database
        const insertQuery = 'INSERT INTO `user` (`name`, `username`, `email`, `password`, `address`, `phonenumber`) VALUES (?, ?, ?, ?, ?, ?)';
        db.query(insertQuery, [name, username, email, passwordHash, address, phone], (err) => {
            // Nếu có lỗi thì trả về lỗi vào trong response
            if (err) {
                console.log(err);
                return res.status(500).json({ message: 'Đã xảy ra lỗi! Vui lòng thử lại!' });
            }

            return res.json({ message: 'Đăng ký thành công' });
        });
    });
};

module.exports = {
    login,
    signup
};