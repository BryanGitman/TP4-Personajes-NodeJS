USE [master]
GO
/****** Object:  Database [DAI-Disney]    Script Date: 19/5/2023 09:25:45 ******/
CREATE DATABASE [DAI-Disney]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DAI-Disney', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DAI-Disney.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DAI-Disney_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DAI-Disney_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DAI-Disney] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DAI-Disney].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DAI-Disney] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DAI-Disney] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DAI-Disney] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DAI-Disney] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DAI-Disney] SET ARITHABORT OFF 
GO
ALTER DATABASE [DAI-Disney] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DAI-Disney] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DAI-Disney] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DAI-Disney] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DAI-Disney] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DAI-Disney] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DAI-Disney] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DAI-Disney] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DAI-Disney] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DAI-Disney] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DAI-Disney] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DAI-Disney] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DAI-Disney] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DAI-Disney] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DAI-Disney] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DAI-Disney] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DAI-Disney] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DAI-Disney] SET RECOVERY FULL 
GO
ALTER DATABASE [DAI-Disney] SET  MULTI_USER 
GO
ALTER DATABASE [DAI-Disney] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DAI-Disney] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DAI-Disney] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DAI-Disney] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DAI-Disney] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DAI-Disney', N'ON'
GO
ALTER DATABASE [DAI-Disney] SET QUERY_STORE = OFF
GO
USE [DAI-Disney]
GO
/****** Object:  User [Personajes]    Script Date: 19/5/2023 09:25:45 ******/
CREATE USER [Personajes] FOR LOGIN [Personajes] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [alumno]    Script Date: 19/5/2023 09:25:45 ******/
CREATE USER [alumno] FOR LOGIN [alumno] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [Personajes]
GO
/****** Object:  Table [dbo].[Pelicula]    Script Date: 19/5/2023 09:25:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pelicula](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Imagen] [varchar](100) NOT NULL,
	[Titulo] [varchar](50) NOT NULL,
	[FechaCreacion] [date] NOT NULL,
	[Calificacion] [float] NOT NULL,
 CONSTRAINT [PK_Pelicula] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personaje]    Script Date: 19/5/2023 09:25:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personaje](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Imagen] [varchar](max) NOT NULL,
	[Nombre] [varchar](max) NOT NULL,
	[Edad] [int] NOT NULL,
	[Peso] [float] NOT NULL,
	[Historia] [varchar](max) NOT NULL,
 CONSTRAINT [PK_Personajes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PersonajesXPeliculas]    Script Date: 19/5/2023 09:25:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonajesXPeliculas](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdPelicula] [int] NOT NULL,
	[IdPersonaje] [int] NOT NULL,
 CONSTRAINT [PK_PersonajesXPeliculas] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Pelicula] ON 

INSERT [dbo].[Pelicula] ([Id], [Imagen], [Titulo], [FechaCreacion], [Calificacion]) VALUES (1, N'https://pics.filmaffinity.com/Mulan-247098384-large.jpg', N'Mulan', CAST(N'1998-06-05' AS Date), 4.7)
INSERT [dbo].[Pelicula] ([Id], [Imagen], [Titulo], [FechaCreacion], [Calificacion]) VALUES (3, N'https://es.web.img3.acsta.net/medias/nmedia/18/68/20/31/19785394.jpg?coixp=47&coiyp=41', N'El rey león', CAST(N'1994-07-07' AS Date), 4.8)
INSERT [dbo].[Pelicula] ([Id], [Imagen], [Titulo], [FechaCreacion], [Calificacion]) VALUES (4, N'https://es.web.img3.acsta.net/pictures/14/03/17/11/47/596263.jpg', N'Tarzán', CAST(N'1999-07-08' AS Date), 4.9)
INSERT [dbo].[Pelicula] ([Id], [Imagen], [Titulo], [FechaCreacion], [Calificacion]) VALUES (6, N'https://www.themoviedb.org/t/p/w500/hMAVsdyj0O13AJF4HK15WxaFsBm.jpg', N'La espada en la piedra', CAST(N'1964-01-16' AS Date), 3.7)
INSERT [dbo].[Pelicula] ([Id], [Imagen], [Titulo], [FechaCreacion], [Calificacion]) VALUES (7, N'https://es.web.img3.acsta.net/pictures/22/05/05/17/26/5021573.jpg', N'Lightyear', CAST(N'2022-06-17' AS Date), 2.8)
SET IDENTITY_INSERT [dbo].[Pelicula] OFF
GO
SET IDENTITY_INSERT [dbo].[Personaje] ON 

INSERT [dbo].[Personaje] ([Id], [Imagen], [Nombre], [Edad], [Peso], [Historia]) VALUES (1, N'https://static.wikia.nocookie.net/disney/images/8/83/FaMul%C3%A1n.png/revision/latest?cb=20130830100817&path-prefix=es', N'Fa Mulan', 16, 55, N'Es una joven muchacha china que se alista en el ejército en lugar de su padre disfrazada de chico para la lucha contra los Hunos, ya que se preocupa de su padre. En el ejército se hace llamar "Ping", y consigue ser el guerrero más querido del Capitán Shang.')
INSERT [dbo].[Personaje] ([Id], [Imagen], [Nombre], [Edad], [Peso], [Historia]) VALUES (2, N'https://static.wikia.nocookie.net/disney/images/1/10/Mushu.png/revision/latest?cb=20130102170724&path-prefix=es', N'Mushu', 3000, 1, N'Es un dragón que hace tiempo metió la pata al cuidar de los antepasados de Mulán, provocando que a uno de los antepasados le cortaran la cabeza. Desde entonces trabaja tocando el gong para despertar a los antepasados. Cuando estos le piden que vaya hacia la estatua del Gran Dragón de Roca y le despierte con el fin de que ayude a Mulán en la guerra, Mushu rompe en pedazos la estatua, por lo que él va a ayudar a Mulán diciendo que a sido enviado por sus antepasados. Mushu ayuda a Mulán a adaptarse en el ejército mientras ella finge ser un chico.')
INSERT [dbo].[Personaje] ([Id], [Imagen], [Nombre], [Edad], [Peso], [Historia]) VALUES (3, N'https://static.wikia.nocookie.net/disney/images/9/95/Simba.png/revision/latest?cb=20121008182056&path-prefix=es', N'Simba', 8, 190, N'Hijo de Mufasa y Sarabi, Simba fue el siguiente a su padre en la línea para gobernar las Tierras del Reino. Sin embargo, después de que su malvado tío Scar asesinó a Mufasa y culpó a Simba por la muerte del antiguo rey, el joven cachorro de león es condenado al exilio mientras que Scar gobierna como rey. Fue entonces cuando Simba regresó a las Tierras del Reino y reclamó su trono y lugar legítimo en el gran ciclo de la vida.')
INSERT [dbo].[Personaje] ([Id], [Imagen], [Nombre], [Edad], [Peso], [Historia]) VALUES (4, N'https://static.wikia.nocookie.net/disney/images/c/c7/Scar.png/revision/latest?cb=20121008181300&path-prefix=es', N'Scar', 13, 165, N'Era el segundo hijo de Ahadi y Uru—que eran, en algún momento, Rey y Reina de las Tierras del Reino—el hermano menor de Mufasa y el tío de Simba. Como el Líder de la Guardia heredó el poderoso Rugido de los Ancestros y escogió a cada miembro, el fuerte, el valiente, el veloz, y con la mejor vista de todo el Reino tal como lo hicieron sus predecesores, incluso protegiendo a los habitantes de las Tierras del Reino manteniendo el Ciclo de la Vida bajo la guía de Rafiki, pero aun así no fue suficiente, durante mucho tiempo siempre fue la sombra de Mufasa pero no podía hacer nada al respecto.')
INSERT [dbo].[Personaje] ([Id], [Imagen], [Nombre], [Edad], [Peso], [Historia]) VALUES (5, N'https://static.wikia.nocookie.net/disney/images/3/30/Tarz%C3%A1n.png/revision/latest?cb=20131018170555&path-prefix=es', N'Tarzán', 18, 80, N'Comúnmente conocido como el "Rey de la Selva", Tarzán fue rescatado y criado por una colonia de monos después de que sus padres fueran asesinados por el sanguinario Sabor. A medida que pasaron los años, se convirtió en un hombre simio, protegiendo a todos los simios, y nunca conociendo el mundo exterior, aparte de la selva.')
INSERT [dbo].[Personaje] ([Id], [Imagen], [Nombre], [Edad], [Peso], [Historia]) VALUES (6, N'https://static.wikia.nocookie.net/disney/images/3/39/Jane_pose.png/revision/latest/scale-to-width-down/217?cb=20161122024349&path-prefix=es', N'Jane Porter', 18, 57, N'Ella y su padre llegaron a África a estudiar los gorilas. Cuando conoció a Tarzán, un hombre salvaje, ella le enseñó todo sobre el mundo y le enseñó a hablar su idioma, y Tarzán le enseñó a hablar gorila. Ella se quedó a vivir en la selva con él, y se casaron, teniendo una boda que incluía una gorila como dama de honor. Ella aun no está muy acostumbrada a vivir en la jungla.')
INSERT [dbo].[Personaje] ([Id], [Imagen], [Nombre], [Edad], [Peso], [Historia]) VALUES (7, N'https://static.wikia.nocookie.net/disney/images/8/8c/Merl%C3%ADn.png/revision/latest?cb=20120320071610&path-prefix=es', N'Merlín', 85, 70, N'Merlín es un viejo y sabio mago que vive en una cabaña del bosque junto con su búho Arquímides. El es el encargado de demostrarle a Grillo las fantásticas cosas de la vida, pues él supone que Grillo puede ser alguien importante algún día.')
INSERT [dbo].[Personaje] ([Id], [Imagen], [Nombre], [Edad], [Peso], [Historia]) VALUES (8, N'https://static.wikia.nocookie.net/disney/images/d/d6/Madam_Mim.jpg/revision/latest/scale-to-width-down/350?cb=20171031230351&path-prefix=es', N'Madam Mim
', 70, 85, N'Se le ve a Mim jugar solitario, hasta que aparece un invitado inesperado Grillo transformado en pájaro, ella se sorprende al principio que es un humano trasformado pero se burla cuando escucha el nombre de su mas grande enemigo Merlín, así que comienza a demostrar sus habilidades mágicas presumiendo ser mejor que el mago con una canción, pero al ver que Grillo aun sobreestimaba a Merlin ella se enoja y procede a eliminarlo jugando con el al principio hasta que Grillo la saca de quicio con un picotazo haciendo enojar a la malvada bruja, antes de que diera el golpe final Merlín aparece para rescatar a Grillo, así que Mim desafía a Merlín un duelo de magia, durante el cual ambos contrincantes se transforman en varios animales. El duelo, uno a uno transformándose en diferentes animales de formas y tamaños de forma cómica, hasta un punto relevante en la película, casi es ganado por Madam Mim, cuando ella se transforma en un dragón, pero Merlín hace uso de su conocimiento sobre el futuro y se transforma a sí mismo en una bacteria que transporta una enfermedad terrible, haciendo que Mim se enferme tanto que no pueda continuar. Y para variar, Merlín le receta que tome el Sol, algo que ella odia.')
INSERT [dbo].[Personaje] ([Id], [Imagen], [Nombre], [Edad], [Peso], [Historia]) VALUES (9, N'https://static.wikia.nocookie.net/pixar/images/2/22/Lightyear_-_Buzz_Lightyear_keyart.png/revision/latest?cb=20220511195306', N'Buzz Lightyear', 25, 80, N'es uno de los personajes principales humanos en la película de Pixar , Lightyear . Él es la inspiración para la figura de acción Buzz Lightyear de la franquicia Toy Story .')
INSERT [dbo].[Personaje] ([Id], [Imagen], [Nombre], [Edad], [Peso], [Historia]) VALUES (10, N'https://static.wikia.nocookie.net/p__/images/2/25/Izzy_hawthorn_render.png/revision/latest?cb=20220908121057&path-prefix=protagonist', N'Izzy Hawthorne', 20, 60, N'Izzy es la nieta súper motivada de Alisha, ochenta y nueve años después en el futuro, quien lidera un equipo voluntario de cadetes motivados que se entrenan para convertirse en protectores de la sociedad naciente que ha tomado forma en el planeta. Izzy sueña con convertirse en una guardabosques espacial como su abuela, pero es más fácil decirlo que hacerlo debido a su miedo al espacio (que finalmente superó).')
SET IDENTITY_INSERT [dbo].[Personaje] OFF
GO
SET IDENTITY_INSERT [dbo].[PersonajesXPeliculas] ON 

INSERT [dbo].[PersonajesXPeliculas] ([Id], [IdPelicula], [IdPersonaje]) VALUES (1, 1, 1)
INSERT [dbo].[PersonajesXPeliculas] ([Id], [IdPelicula], [IdPersonaje]) VALUES (2, 1, 2)
INSERT [dbo].[PersonajesXPeliculas] ([Id], [IdPelicula], [IdPersonaje]) VALUES (3, 3, 3)
INSERT [dbo].[PersonajesXPeliculas] ([Id], [IdPelicula], [IdPersonaje]) VALUES (4, 3, 4)
INSERT [dbo].[PersonajesXPeliculas] ([Id], [IdPelicula], [IdPersonaje]) VALUES (5, 4, 5)
INSERT [dbo].[PersonajesXPeliculas] ([Id], [IdPelicula], [IdPersonaje]) VALUES (6, 4, 6)
INSERT [dbo].[PersonajesXPeliculas] ([Id], [IdPelicula], [IdPersonaje]) VALUES (7, 6, 7)
INSERT [dbo].[PersonajesXPeliculas] ([Id], [IdPelicula], [IdPersonaje]) VALUES (8, 6, 8)
INSERT [dbo].[PersonajesXPeliculas] ([Id], [IdPelicula], [IdPersonaje]) VALUES (9, 7, 9)
INSERT [dbo].[PersonajesXPeliculas] ([Id], [IdPelicula], [IdPersonaje]) VALUES (10, 7, 10)
SET IDENTITY_INSERT [dbo].[PersonajesXPeliculas] OFF
GO
ALTER TABLE [dbo].[PersonajesXPeliculas]  WITH CHECK ADD  CONSTRAINT [FK_PersonajesXPeliculas_Pelicula] FOREIGN KEY([IdPelicula])
REFERENCES [dbo].[Pelicula] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PersonajesXPeliculas] CHECK CONSTRAINT [FK_PersonajesXPeliculas_Pelicula]
GO
ALTER TABLE [dbo].[PersonajesXPeliculas]  WITH CHECK ADD  CONSTRAINT [FK_PersonajesXPeliculas_Personaje] FOREIGN KEY([IdPersonaje])
REFERENCES [dbo].[Personaje] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PersonajesXPeliculas] CHECK CONSTRAINT [FK_PersonajesXPeliculas_Personaje]
GO
USE [master]
GO
ALTER DATABASE [DAI-Disney] SET  READ_WRITE 
GO
