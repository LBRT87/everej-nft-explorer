var express = require('express');
var app = express()

var userRouter = require("./routes/users.js")
var commentRouter = require("./routes/comment.js")
var nftsRouter = require("./routes/nft.js")
app.use(express.json());

app.use('/user', userRouter);
app.use('/comment',commentRouter)
app.use('/nfts',nftsRouter)

app.get("/",function(req,res) {
    res.send("API EvereJ is Running...")
})
module.exports = app;
