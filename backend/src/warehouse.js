// Xử lý tạo mới kho
const createWarehouse = (req, res, db) => {
    const { idproduct, soluong } = req.body;

    // Kiểm tra các trường dữ liệu bắt buộc
    if (!idproduct || !soluong) {
        return res.status(400).json({ message: 'ID sản phẩm và số lượng là bắt buộc' });
    }

    // Thực hiện truy vấn để thêm kho mới vào database
    const query = 'INSERT INTO kho (idproduct, soluong) VALUES (?, ?)';
    db.query(query, [idproduct, soluong], (err, results) => {
        // Nếu có lỗi thì trả về thông báo lỗi
        if (err) {
            return res.status(500).json({ message: 'Đã xảy ra lỗi. Vui lòng thử lại sau!' });
        }
        res.status(201).json({ message: 'Đã tạo mục nhập kho thành công', warehouseId: results.insertId });
    });
};

// Xử lý cập nhật kho
const editWarehouse = (req, res, db) => {
    const { id } = req.params;
    const { idproduct, soluong } = req.body;

    // Kiểm tra các trường dữ liệu bắt buộc
    if (!idproduct || !soluong) {
        return res.status(400).json({ message: 'ID sản phẩm và số lượng là bắt buộc' });
    }

    // Thực hiện truy vấn để cập nhật kho
    const query = 'UPDATE kho SET idproduct = ?, soluong = ? WHERE idwardhouse = ?';
    db.query(query, [idproduct, soluong, id], (err, results) => {
        // Nếu có lỗi thì trả về thông báo lỗi
        if (err) {
            return res.status(500).json({ message: 'Đã xảy ra lỗi. Vui lòng thử lại sau!' });
        }
        // Nếu không tìm thấy kho thì trả về lỗi
        if (results.affectedRows === 0) {
            return res.status(404).json({ message: 'Không tìm thấy mục nhập kho' });
        }
        res.json({ message: 'Đã cập nhật mục nhập kho thành công' });
    });
};

// Xử lý xóa kho
const deleteWarehouse = (req, res, db) => {
    const { id } = req.params;

    // Kiểm tra xem id kho có tồn tại không
    if (!id) {
        return res.status(400).json({ message: 'ID kho là bắt buộc' });
    }

    // Thực hiện truy vấn để xóa kho
    const query = 'DELETE FROM kho WHERE idwardhouse = ?';
    db.query(query, [id], (err, results) => {
        // Nếu có lỗi thì trả về thông báo lỗi
        if (err) {
            return res.status(500).json({ message: 'Đã xảy ra lỗi. Vui lòng thử lại sau!' });
        }
        // Nếu không tìm thấy kho thì trả về lỗi
        if (results.affectedRows === 0) {
            return res.status(404).json({ message: 'Không tìm thấy mục nhập kho' });
        }
        res.json({ message: 'Đã xóa mục nhập kho thành công' });
    });
};

// Xử lý lấy danh sách kho
const getWarehouses = (req, res, db) => {
    const query = 'SELECT * FROM kho';
    db.query(query, (err, results) => {
        if (err) {
            return res.status(500).json({ message: 'Đã xảy ra lỗi. Vui lòng thử lại sau!' });
        }
        res.json(results);
    });
};

module.exports = {
    createWarehouse,
    editWarehouse,
    deleteWarehouse,
    getWarehouses
};