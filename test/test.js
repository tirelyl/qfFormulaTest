var calc = require('../index');

try {
  let params = {
    email: "邮箱",
    nickName: "昵称",
    alias: "备注",
    jaInfo: {
      sid: "1140379009", 
      organize: "软件学院",
      organizeId: "03700",
      userType: "student",
      name: "姓名"
    }
  }
  // let a = calc.calculate('CONCAT(JAID(), "asdasd")', params);
  // console.log(a);
  // console.log(calc.calculate('JANAME()', params));
  // console.log(calc.calculate('JATYPE()', params));
  // console.log(calc.calculate('JADEPTID()', params));
  // console.log(calc.calculate('JADEPTNAME()', params));
  let a = calc.calculate('CONCAT(GETUSERNAME(), GETUSEREMAIL())', params);
  console.log(a);
}
catch(err) {
  console.log('inside err');
  console.log(err);
}

