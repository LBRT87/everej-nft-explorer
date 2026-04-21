var express = require('express');
const db = require("../database/database");
var router = express.Router();

router.post("/createNft", function(req,res) {
    const {ticker,description,price,image_url,creator} = req.body

    if (!ticker || !price) {
        return res.status(400).json({
            message: "Title + Price Harus ada"
        })
    }

    db.query(
        "INSERT INTO nfts (ticker,description,price,image_url,creator) VALUES (?,?,?,?,?)",
        [ticker,description,price,image_url,creator],
        (errorMessage,result) => { 
        if (errorMessage){
            return res.status(500).json({
                message:errorMessage.message
            })
        }
        res.status(201).json({
            message:"Minting Nft",
            id:result.insertId
        })
        }
    )

})
router.get("/getNft/:id",(req,res) => {
    console.log(req.params.id)
    db.query(
        "SELECT * FROM nfts WHERE id=?",
        [req.params.id],
        (errorMessage,result) => {
            if (errorMessage) {
                return res.status(500).json({
                    message:errorMessage.message
                })
            }
            res.status(200).json(result[0])
            console.log('tes ini get nft')
        }
    )
})

router.delete("/deleteNft/:id",(req,res) => {
    console.log(req.params.id)
    db.query(
        "DELETE FROM nfts WHERE id = ?",
        [req.params.id],
        (errorMessage,result) => {
            if (errorMessage){
                return res.status(500).json({
                    message:errorMessage.message
                })
            }
            res.status(200).json({
                message:"Burning NFT"
            })
            console.log('ini delte')
        }
    )
})

module.exports = router