var express = require('express');
const db = require("../database/database");
var router = express.Router();

router.post("/registration", function (req,res) {
  const {email,password} = req.body

  if (!email) {
    return res.status(400).json({
        message: "E-mail Must be Required !"
    })
  }

  if (!email.includes('@')){
    return res.status(400).json({
      message: "Please Use Format Email @"
    })
  }

  if (email.length < 8) {
    return res.status(400).json(
      {
        message:"At least E-mail length more than 8 characters"
      }
    )
  }

  if (!password) {
    return res.status(400).json({
        message:"Password Must be Required!"
    })
  }

  if (password.length < 6) {
    return res.status(400).json({
      message:"Password Must Be More Equal Than 6 Characters"
    })
  }

  db.query(
    "SELECT * FROM users WHERE email = ?",
    [email],
    (errorMessage, result) => {
      console.log('masuk sini')
      if (errorMessage) {
        return res.status(500).json({
          message: errorMessage.message
        });
      }

      if (result.length > 0) {
        console.log('Email udah ada')
        return res.status(409).json({
          message: "Email sudah Registered di EvereJ"
        });
      }
      db.query(
        "INSERT INTO users (email,password) VALUES (?,?)",
        [email,password],
        (errorMessage,result) => {
            if (errorMessage){
                return res.status(500).json({
                    message: errorMessage.message
                })
              }
    
            res.status(201).json({
                message:"Registration Succeedd.."
            })
            console.log('Sukses Regis')
        }
      )
    
    },
  
  )

})

router.post("/login", function (req,res) {
    const {email,password} = req.body
    db.query(
        "SELECT * FROM users WHERE email = ? AND password = ?",
        [email,password],
        (errorMessage,result) => {
            if (errorMessage) {
                return res.status(500).json({
                    message: "Invalid E-mail Password"
                })
            }

            if (result.length === 0) {
              return res.status(401).json({
                message:"Invalid E-mail or Password"
              })
            }
            
            return res.status(200).json({
                message:"Login Succedd..."
            })
        }
    )
})


module.exports = router 