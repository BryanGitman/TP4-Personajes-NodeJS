import express from "express";
import cors from "cors";
import {DisneyService} from "./src/services/disney-services.js";

const app = express();
const port = 3000;
app.use(express.json());
app.use(cors());

app.get('/characters', async (req, res) =>
{
    const personajes = await DisneyService.getAllC();
    res.status(200).send(personajes);
});

app.get('/characters?:nombre&:edad&:peso&:pelicula', async (req, res) =>
{
    const personajes = await DisneyService.getByFilterC(req.params);
    res.status(200).send(personajes);
});

app.get('/characters/:id', async (req, res) =>
{
    const personaje = await DisneyService.getByIdC(req.params.id);
    res.status(200).send(personaje);
});

app.post('/characters', async (req, res) =>
{
    try {
        await DisneyService.insertC(req.body);
        res.status(200).json({message: 'Personaje creado'});
    } catch(error){
        console.log(error);
        res.status(500).json({error: 'Falló el insert'});
    }
});

app.put('/characters/:id', async (req, res) =>
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

app.delete('/characters/:id', async (req, res) =>
{
    try {
        await DisneyService.deleteByIdC(req.params.id);
        res.status(200).json({message: 'Personaje eliminado'});
    } catch(error){
        console.log(error);
        res.status(500).json({error: 'Falló el delete'});
    }
});

app.get('/movies', async (req, res) =>
{
    const movies = await DisneyService.getAllM();
    res.status(200).send(movies);
});

app.get('/movies/:id', async (req, res) =>
{
    const movie = await DisneyService.getByIdM(req.params.id);
    res.status(200).send(movie);
});

app.post('/movies', async (req, res) =>
{
    try {
        await DisneyService.insertM(req.body);
        res.status(200).json({message: 'Película creada'});
    } catch(error){
        console.log(error);
        res.status(500).json({error: 'Falló el insert'});
    }
});

app.put('/movies/:id', async (req, res) =>
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

app.delete('/movies/:id', async (req, res) =>
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