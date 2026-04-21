var express = require("express")
const db = require("../database/database")
const { route } = require("./users")
var router = express.Router()

router.post("/createComment", function (req,res) {
    const {product_id,user,comment} = req.body
    db.query(
        "INSERT INTO comments (product_id,user,comment) VALUES (?,?,?)",
        [product_id,user,comment],
        (errorMessage,result) => {
            if (errorMessage) {
                return res.status(500).json({
                    message: errorMessage.message
                })
            }
            res.status(201).json({
                message: "Post Comment Success..."
            })
            console.log('berhasilkomen')
        }
    )
})

router.get("/readComment/:id", function(req,res) {
    console.log("id=",req.params.id)
    const id_produk = req.params.id
    db.query(
        "SELECT * FROM comments WHERE product_id = ?",
        [id_produk],
        (errorMessage,result) => {
            if (errorMessage) {
                return res.status(500).json({
                    message:errorMessage.message
                })
            }
            res.json(result)
        }
    )
})

router.put("/updateComment/:id", function(req,res){
    const commentId = req.params.id
    const {comment} = req.body

    db.query(
        "UPDATE comments SET comment = ? WHERE id = ?",
        [comment,commentId],
        (errorMessage,result) => {
            if (errorMessage) {
                return res.status(500).json({
                    message:errorMessage.message
                })
            }
            res.json({
                message: "Update Comment Success.."
            })
            console.log('Update kok')
        }
    )
})

router.delete("/deleteComment/:id",function(req,res) {
    const commentId = req.params.id
    const {comment} = req.body

    db.query(
        "DELETE FROM comments WHERE id = ?",
        [commentId],
        (errorMessage,result) => {
            if (errorMessage){
                return res.status(500).json({
                    message:errorMessage
                })
            }
            res.json({
                message: "Delete Comment Success..."
            })
            console.log('delete bro')
        }
    )
})

module.exports = router