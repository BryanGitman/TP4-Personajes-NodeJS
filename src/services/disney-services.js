import {config} from '../../dbconfig.js';
import sql from 'mssql';

export class DisneyService
{
    static getAllC = async () =>
    {
        let returnList = null;
        try{
            let pool = await sql.connect(config);
            let result = await pool.request().query('SELECT Imagen, Nombre, Id FROM Personaje');
            returnList = result.recordsets[0];
        } catch(error){
            console.log(error);
        }
        return returnList;
    }

    static getByIdC = async (id) =>
    {
        let returnEntity = null;
        try{
            let pool = await sql.connect(config);
            let result = await pool.request().input('pId',sql.Int,id).query('SELECT * FROM Personaje WHERE Id = @pId');
            returnEntity = result.recordsets[0][0];
            result = await pool.request().input('pId',sql.Int,id).query('SELECT pel.Titulo FROM Pelicula pel inner join PersonajesXPeliculas pxp on pxp.IdPelicula = pel.Id inner join Personaje per on pxp.IdPersonaje = per.Id WHERE per.Id = @pId');
            returnEntity['Peliculas'] = result.recordsets[0];
        } catch(error){
            console.log(error);
        }
        return returnEntity;
    }

    static insertC = async (personaje) =>
    {
        const {Imagen, Nombre, Edad, Peso, Historia} = personaje;
        let pool = await sql.connect(config);
        const request = new sql.Request(pool);
        request
            .input('pImagen',sql.NVarChar,Imagen)
            .input('pNombre',sql.NVarChar,Nombre)
            .input('pEdad',sql.Int,Edad)
            .input('pPeso',sql.Float,Peso)
            .input('pHistoria',sql.NVarChar,Historia)
            .query('INSERT INTO Personaje (Imagen, Nombre, Edad, Peso, Historia) VALUES (@pImagen, @pNombre, @pEdad, @pPeso, @pHistoria)');
    }

    static updateC = async (personaje) =>
    {
        const {Id, Imagen, Nombre, Edad, Peso, Historia} = personaje;
        let pool = await sql.connect(config);
        const request = new sql.Request(pool);
        request
            .input('pId',sql.Int,Id)
            .input('pImagen',sql.NVarChar,Imagen)
            .input('pNombre',sql.NVarChar,Nombre)
            .input('pEdad',sql.Int,Edad)
            .input('pPeso',sql.Float,Peso)
            .input('pHistoria',sql.NVarChar,Historia)
            .query('UPDATE Personaje SET Imagen = @pImagen, Nombre = @pNombre, Edad = @pEdad, Peso = @pPeso, Historia = @pHistoria WHERE Id = @pId');
    }

    static deleteByIdC = async (id) =>
    {
        let pool = await sql.connect(config);
        const request = new sql.Request(pool);
        request.input('pId',sql.Int,id).query('DELETE FROM Personaje WHERE Id = @pId');
    }

    static getByFilterC = async (params) =>
    {
        let returnEntity = null;
        let where = '';
        if(params.nombre != null)
        {
            where += 'per.Nombre like @pNombre AND ';
        }
        if(params.edad != null)
        {
            where += 'per.Edad = @pEdad AND ';
        }
        if(params.peso != null)
        {
            where += 'per.Peso = @pPeso AND ';
        }
        if(params.pelicula != null)
        {
            where += 'pel.Id = @pPeli AND ';
        }
        try{
            let pool = await sql.connect(config);
            let result = await pool.request()
                .input('pNombre',sql.NVarChar,params.nombre)
                .input('pEdad',sql.Int,params.edad)
                .input('pPeso',sql.Float,params.peso)
                .input('pPeli',sql.Int,params.pelicula)
                .query('SELECT per.Imagen, per.Nombre, per.Id FROM Personaje inner join PersonajesXPeliculas pxp on pxp.IdPersonaje = per.Id inner join Pelicula pel on pxp.IdPelicula = pel.Id WHERE ' + where.slice(0,this.length-6));
            returnEntity = result.recordsets[0];
        } catch(error){
            console.log(error);
        }
        return returnEntity;
    }

    static getAllM = async () =>
    {
        let returnList = null;
        try{
            let pool = await sql.connect(config);
            let result = await pool.request().query('SELECT Id, Imagen, Titulo, FechaCreacion FROM Pelicula');
            returnList = result.recordsets[0];
        } catch(error){
            console.log(error);
        }
        return returnList;
    }

    static getByIdM = async (id) =>
    {
        let returnEntity = null;
        try{
            let pool = await sql.connect(config);
            let result = await pool.request().input('pId',sql.Int,id).query('SELECT * FROM Pelicula WHERE Id = @pId');
            returnEntity = result.recordsets[0][0];
            result = await pool.request().input('pId',sql.Int,id).query('SELECT per.Nombre FROM Personaje per inner join PersonajesXPeliculas pxp on pxp.IdPersonaje = per.Id inner join Pelicula pel on pxp.IdPelicula = pel.Id WHERE pel.Id = @pId');
            returnEntity['Personajes'] = result.recordsets[0];
        } catch(error){
            console.log(error);
        }
        return returnEntity;
    }

    static insertM = async (pelicula) =>
    {
        const {Imagen, Titulo, FechaCreacion, Calificacion} = pelicula;
        let pool = await sql.connect(config);
        const request = new sql.Request(pool);
        request
            .input('pImagen',sql.NVarChar,Imagen)
            .input('pTitulo',sql.NVarChar,Titulo)
            .input('pFechaCreacion',sql.Date,FechaCreacion)
            .input('pCalificacion',sql.Float,Calificacion)
            .query('INSERT INTO Pelicula (Imagen, Titulo, FechaCreacion, Calificacion) VALUES (@pImagen, @pTitulo, @pFechaCreacion, @pCalificacion)');
    }

    static updateM = async (pelicula) =>
    {
        const {Id, Imagen, Titulo, FechaCreacion, Calificacion} = pelicula;
        let pool = await sql.connect(config);
        const request = new sql.Request(pool);
        request
            .input('pId',sql.Int,Id)
            .input('pImagen',sql.NVarChar,Imagen)
            .input('pTitulo',sql.NVarChar,Titulo)
            .input('pFechaCreacion',sql.Date,FechaCreacion)
            .input('pCalificacion',sql.Float,Calificacion)
            .query('UPDATE Pelicula SET Imagen = @pImagen, Titulo = @pTitulo, FechaCreacion = @pFechaCreacion, Calificacion = @pCalificacion WHERE Id = @pId');
    }

    static deleteByIdM = async (id) =>
    {
        let pool = await sql.connect(config);
        const request = new sql.Request(pool);
        request.input('pId',sql.Int,id).query('DELETE FROM Pelicula WHERE Id = @pId');
    }
}