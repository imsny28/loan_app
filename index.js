var express = require('express');
var router = express.Router();

const classroomController = require('../controllers').classroom;
const studentController = require('../controllers').student;
const lecturerController = require('../controllers').lecturer;
const courseController = require('../controllers').course;
const userController = require('../controllers').user;
const customerController = require('../controllers').customer;
const loanController = require('../controllers').loan;
const collateralController = require('../controllers').collateral;
const attributeoptionController = require('../controllers').attributeoption;

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});


router.get('/api/classroom', classroomController.list);
router.get('/api/classroom/:id', classroomController.getById);
router.post('/api/classroom', classroomController.add);
router.put('/api/classroom/:id', classroomController.update);
router.delete('/api/classroom/:id', classroomController.delete);
router.post('/api/classroom/add_with_students', classroomController.addWithStudents);

router.get('/api/student', studentController.list);
router.get('/api/student/:id', studentController.getById);
router.post('/api/student', studentController.add);
router.put('/api/student/:id', studentController.update);
router.delete('/api/student/:id', studentController.delete);
router.post('/api/student/add_course', studentController.addCourse);


router.get('/api/lecturer', lecturerController.list);
router.get('/api/lecturer/:id', lecturerController.getById);
router.post('/api/lecturer', lecturerController.add);
router.put('/api/lecturer/:id', lecturerController.update);
router.delete('/api/lecturer/:id', lecturerController.delete);
router.post('/api/lecturer/add_with_course', lecturerController.addWithCourse);

router.get('/api/course', courseController.list);
router.get('/api/course/:id', courseController.getById);
router.post('/api/course', courseController.add);
router.put('/api/course/:id', courseController.update);
router.delete('/api/course/:id', courseController.delete);

// User Route
router.get('/api/users', userController.list);
router.get('/api/user/:id', userController.getById);
router.post('/api/user', userController.add);
router.put('/api/user/:id', userController.update);
router.delete('/api/user/:id', userController.delete);

// customer Route
router.get('/api/customers', customerController.list);
router.get('/api/customer/:id', customerController.getById);
router.post('/api/customer', customerController.add);
router.put('/api/customer/:id', customerController.update);
router.delete('/api/customer/:id', customerController.delete);

// Loan Route
router.post('/api/loan', loanController.add);
router.put('/api/loan/:id', loanController.update);

// collateral
router.get('/collaterals', collateralController.list);
router.get('/collateral/new', collateralController.new);
router.post('/api/collateral', collateralController.add);


// attributeoption
router.post('/api/attributeoption', attributeoptionController.add);


module.exports = router;
