const express = require('express')
const app = express()
const mongoose = require('mongoose');
const { userInfo } = require('os');
const path = require('path')

const PORT = 3000;
const URI = "mongodb://127.0.0.1:27017/tasks";

let Task = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    date: {
        type: Date,
        //required: true
    },
    status: {
        type: Boolean,
        default: false
    }
});

const task = mongoose.model('tasks', Task)

app.use(express.json())
app.use(express.urlencoded({ extended: false}))
app.use(express.static(path.join(__dirname, 'public')))
app.set("views", __dirname + '/public/views')
app.set('view engine', 'ejs')


app.get('/', (req, res, next) => {
    res.render('index')
})

app.get('/get-tasks', async (req, res, next) => {
    await task.find((err, obj) => {
        if (err) {
            console.log(err)
            return res.status(500).send('Database error')
        }
        return res.send(obj)
    })
})

app.get('/get-task/:id', async (req, res, next) => {
    await task.findById(req.params.id, (err, obj) => {
        if (err) {
            console.log(err)
            return res.status(500).send('Database error')
        }
        return res.send(obj)
    })
})


app.post('/create', async (req, res, next) => {
    var newTask = new task({
        name: req.body.name,
        date: req.body.date,
    });

    await newTask.save((err, obj) => {
        if(err){
            return res.status(500).send('Database error')
        }
        return res.send(obj)
    })
})

app.put('/update-task/:id', async (req, res, next) => {
    console.log("Inisde the update function")
    await task.findOneAndUpdate({_id: req.params.id}, req.body,
        { new: true }, (err, obj) => {
        if(err) {
            console.log(err)
            return res.status(500).send('Database error')
        }
        return res.send(obj)
    })
})

app.delete('/delete-task/:id', async (req, res, next) => {
    await task.findOneAndDelete({_id: req.params.id}, (err, obj) => {
        if (err) {
            console.log(err)
            return res.status(500).send('Database error')
        }
        return res.send(obj)
    })
})




mongoose.set('useFindAndModify', false);
mongoose.connect(URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useCreateIndex: true,
    useFindAndModify: true
}, (err) => {
    if (err) {
        return console.log(err)
    }
    app.listen(PORT, () => {
        console.log(`Server running ==> ${PORT}`)
    })
})