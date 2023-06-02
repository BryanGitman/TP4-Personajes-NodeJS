import express from "express";
import cors from "cors";
import {DisneyService} from "./src/services/disney-services.js";

const app = express();
const port = 3000;
app.use(express.json());
app.use(cors());

//Autenticación:
import {config} from "./authconfig.js";
import jwt from "jsonwebtoken";
import authJwt from "./src/middlewares/authJwt.js";

app.use(function(req, res, next) {
    res.header(
      "Access-Control-Allow-Headers",
      "x-access-token, Origin, Content-Type, Accept"
    );
    next();
});

app.post('/auth/login', async (req, res) =>
{
    try {
        let user = req.body.user;
        if (user != process.env.DB_USER) 
        {
            return res.status(404).send({ message: "Usuario no válido." });
        }
        if (req.body.password != process.env.DB_PASSWORD) 
        {
            return res.status(401).send({
            accessToken: null,
            message: "Contraseña no válida!"
            });
        }
        let token = jwt.sign({ id: user.id }, config.secret, {
            expiresIn: 3600
        });
        res.status(200).send({
            message: "Sesión iniciada exitosamente",
            user: user,
            accessToken: token
        });
    } catch(error){
        console.log(error);
        res.status(500).json({error: 'Falló el login'});
    }
});
//Fin autenticación

app.get('/characters', [authJwt.verifyToken], async (req, res) => 
{
    const filters = req.query;
    const personajes = await DisneyService.getAllC(filters);
    res.status(200).send(personajes);
});

app.get('/characters/:id', [authJwt.verifyToken], async (req, res) =>
{
    const personaje = await DisneyService.getByIdC(req.params.id);
    res.status(200).send(personaje);
});

app.post('/characters', [authJwt.verifyToken], async (req, res) =>
{
    try {
        await DisneyService.insertC(req.body);
        res.status(200).json({message: 'Personaje creado'});
    } catch(error){
        console.log(error);
        res.status(500).json({error: 'Falló el insert'});
    }
});

app.put('/characters/:id', [authJwt.verifyToken], async (req, res) =>
{
    if(req.params.id == req.body.Id)
    {
        try {
            await DisneyService.updateC(req.body);
            res.status(200).json({message: 'Personaje actualizado'});
        } catch(error){
            console.log(error);
            res.status(500).json({error: 'Falló el update'});
        }
    }
    else
    {
        res.status(400).json({error: 'El id no coincide con el personaje'});
    }
});

app.delete('/characters/:id', [authJwt.verifyToken], async (req, res) =>
{
    try {
        await DisneyService.deleteByIdC(req.params.id);
        res.status(200).json({message: 'Personaje eliminado'});
    } catch(error){
        console.log(error);
        res.status(500).json({error: 'Falló el delete'});
    }
});

app.get('/movies', [authJwt.verifyToken], async (req, res) =>
{
    const filters = req.query;
    const movies = await DisneyService.getAllM(filters);
    res.status(200).send(movies);
});

app.get('/movies/:id', [authJwt.verifyToken], async (req, res) =>
{
    const movie = await DisneyService.getByIdM(req.params.id);
    res.status(200).send(movie);
});

app.post('/movies', [authJwt.verifyToken], async (req, res) =>
{
    try {
        await DisneyService.insertM(req.body);
        res.status(200).json({message: 'Película creada'});
    } catch(error){
        console.log(error);
        res.status(500).json({error: 'Falló el insert'});
    }
});

app.put('/movies/:id', [authJwt.verifyToken], async (req, res) =>
{
    if(req.params.id == req.body.Id)
    {
        try {
            await DisneyService.updateM(req.body);
            res.status(200).json({message: 'Película actualizada'});
        } catch(error){
            console.log(error);
            res.status(500).json({error: 'Falló el update'});
        }
    }
    else
    {
        res.status(400).json({error: 'El id no coincide con la película'});
    }
});

app.delete('/movies/:id', [authJwt.verifyToken], async (req, res) =>
{
    try {
        await DisneyService.deleteByIdM(req.params.id);
        res.status(200).json({message: 'Película eliminada'});
    } catch(error){
        console.log(error);
        res.status(500).json({error: 'Falló el delete'});
    }
});

app.listen(port, () => {
    console.log(`Listening on port ${port}`);
})