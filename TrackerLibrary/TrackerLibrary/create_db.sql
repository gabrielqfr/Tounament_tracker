USE [master]
GO
/****** Object:  Database [Tournament_tracker]    Script Date: 16/10/2020 11:58:14 ******/
CREATE DATABASE [Tournament_tracker]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Tournament_tracker', FILENAME = N'INSERT YOUR PATH' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Tournament_tracker_log', FILENAME = N'INSERT YOUR PATH' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Tournament_tracker] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Tournament_tracker].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Tournament_tracker] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Tournament_tracker] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Tournament_tracker] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Tournament_tracker] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Tournament_tracker] SET ARITHABORT OFF 
GO
ALTER DATABASE [Tournament_tracker] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Tournament_tracker] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Tournament_tracker] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Tournament_tracker] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Tournament_tracker] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Tournament_tracker] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Tournament_tracker] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Tournament_tracker] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Tournament_tracker] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Tournament_tracker] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Tournament_tracker] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Tournament_tracker] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Tournament_tracker] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Tournament_tracker] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Tournament_tracker] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Tournament_tracker] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Tournament_tracker] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Tournament_tracker] SET RECOVERY FULL 
GO
ALTER DATABASE [Tournament_tracker] SET  MULTI_USER 
GO
ALTER DATABASE [Tournament_tracker] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Tournament_tracker] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Tournament_tracker] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Tournament_tracker] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Tournament_tracker] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Tournament_tracker', N'ON'
GO
ALTER DATABASE [Tournament_tracker] SET QUERY_STORE = OFF
GO
USE [Tournament_tracker]
GO
/****** Object:  Table [dbo].[Matchup]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Matchup](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[WinnerId] [int] NULL,
	[MatchupRound] [int] NOT NULL,
	[TournamentId] [int] NOT NULL,
 CONSTRAINT [PK_Matchup] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MatchupEntries]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MatchupEntries](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[MatchupId] [int] NOT NULL,
	[ParentMatchId] [int] NULL,
	[TeamCompetingId] [int] NULL,
	[Score] [int] NULL,
 CONSTRAINT [PK_MatchupEntries] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[People]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[People](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[EmailAddress] [nvarchar](50) NOT NULL,
	[CellphoneNumber] [varchar](20) NULL,
	[CreateDate] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_People] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Prizes]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Prizes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[PlaceNumber] [int] NOT NULL,
	[PlaceName] [nvarchar](50) NOT NULL,
	[PrizeAmount] [money] NOT NULL,
	[PrizePercentage] [float] NOT NULL,
 CONSTRAINT [PK_Prizes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TeamMembers]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamMembers](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TeamId] [int] NOT NULL,
	[PersonId] [int] NOT NULL,
 CONSTRAINT [PK_TeamMembers] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Teams]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teams](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TeamName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Teams] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TournamentEntries]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TournamentEntries](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TournamentId] [int] NOT NULL,
	[TeamId] [int] NOT NULL,
 CONSTRAINT [PK_TournamentEntries] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TournamentPrizes]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TournamentPrizes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TournamentId] [int] NOT NULL,
	[PrizeId] [int] NOT NULL,
 CONSTRAINT [PK_TournamentPrizes] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tournaments]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tournaments](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[TournamentName] [nvarchar](50) NOT NULL,
	[EntryFee] [money] NOT NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_Tournaments] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[People] ADD  CONSTRAINT [DF_People_CreateDate]  DEFAULT (getutcdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Prizes] ADD  CONSTRAINT [DF_Prizes_PrizeAmount]  DEFAULT ((0)) FOR [PrizeAmount]
GO
ALTER TABLE [dbo].[Prizes] ADD  CONSTRAINT [DF_Prizes_PrizePercentage]  DEFAULT ((0)) FOR [PrizePercentage]
GO
ALTER TABLE [dbo].[Matchup]  WITH NOCHECK ADD  CONSTRAINT [FK_Matchup_Teams] FOREIGN KEY([WinnerId])
REFERENCES [dbo].[Teams] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Matchup] CHECK CONSTRAINT [FK_Matchup_Teams]
GO
ALTER TABLE [dbo].[Matchup]  WITH CHECK ADD  CONSTRAINT [FK_Matchup_Tournaments] FOREIGN KEY([TournamentId])
REFERENCES [dbo].[Tournaments] ([id])
GO
ALTER TABLE [dbo].[Matchup] CHECK CONSTRAINT [FK_Matchup_Tournaments]
GO
ALTER TABLE [dbo].[MatchupEntries]  WITH CHECK ADD  CONSTRAINT [FK_MatchupEntries_Matchup] FOREIGN KEY([MatchupId])
REFERENCES [dbo].[Matchup] ([id])
GO
ALTER TABLE [dbo].[MatchupEntries] CHECK CONSTRAINT [FK_MatchupEntries_Matchup]
GO
ALTER TABLE [dbo].[MatchupEntries]  WITH CHECK ADD  CONSTRAINT [FK_MatchupEntries_Teams] FOREIGN KEY([TeamCompetingId])
REFERENCES [dbo].[Teams] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[MatchupEntries] CHECK CONSTRAINT [FK_MatchupEntries_Teams]
GO
ALTER TABLE [dbo].[TeamMembers]  WITH CHECK ADD  CONSTRAINT [FK_TeamMembers_People] FOREIGN KEY([PersonId])
REFERENCES [dbo].[People] ([id])
GO
ALTER TABLE [dbo].[TeamMembers] CHECK CONSTRAINT [FK_TeamMembers_People]
GO
ALTER TABLE [dbo].[TeamMembers]  WITH CHECK ADD  CONSTRAINT [FK_TeamMembers_Teams] FOREIGN KEY([TeamId])
REFERENCES [dbo].[Teams] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[TeamMembers] CHECK CONSTRAINT [FK_TeamMembers_Teams]
GO
ALTER TABLE [dbo].[TournamentEntries]  WITH CHECK ADD  CONSTRAINT [FK_TournamentEntries_Teams] FOREIGN KEY([TeamId])
REFERENCES [dbo].[Teams] ([id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[TournamentEntries] CHECK CONSTRAINT [FK_TournamentEntries_Teams]
GO
ALTER TABLE [dbo].[TournamentEntries]  WITH CHECK ADD  CONSTRAINT [FK_TournamentEntries_Tournaments] FOREIGN KEY([TournamentId])
REFERENCES [dbo].[Tournaments] ([id])
GO
ALTER TABLE [dbo].[TournamentEntries] CHECK CONSTRAINT [FK_TournamentEntries_Tournaments]
GO
ALTER TABLE [dbo].[TournamentPrizes]  WITH CHECK ADD  CONSTRAINT [FK_TournamentPrizes_Prizes] FOREIGN KEY([PrizeId])
REFERENCES [dbo].[Prizes] ([id])
GO
ALTER TABLE [dbo].[TournamentPrizes] CHECK CONSTRAINT [FK_TournamentPrizes_Prizes]
GO
ALTER TABLE [dbo].[TournamentPrizes]  WITH CHECK ADD  CONSTRAINT [FK_TournamentPrizes_Tournaments] FOREIGN KEY([TournamentId])
REFERENCES [dbo].[Tournaments] ([id])
GO
ALTER TABLE [dbo].[TournamentPrizes] CHECK CONSTRAINT [FK_TournamentPrizes_Tournaments]
GO
/****** Object:  StoredProcedure [dbo].[spMatchup_Insert]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spMatchup_Insert]
	@TournamentId int,
	@MatchupRound int,
	@id int = 0 output
AS
BEGIN
	SET NOCOUNT ON;

    insert into dbo.Matchup (TournamentId, MatchupRound)
	values (@TournamentId, @MatchupRound)

	select @id = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[spMatchupEntries_GetByMatchup]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spMatchupEntries_GetByMatchup] 
	@MatchupId int
AS
BEGIN
	SET NOCOUNT ON;
	
	select m.*
	from dbo.MatchupEntries m
	where m.MatchupId = @MatchupId
END
GO
/****** Object:  StoredProcedure [dbo].[spMatchupEntries_Insert]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spMatchupEntries_Insert]
	@MatchupId int,
	@ParentMatchId int,
	@TeamCompetingId int,
	@Score int,
	@id int = 0 output
AS
BEGIN
	SET NOCOUNT ON;

    insert into dbo.MatchupEntries ( MatchupId, ParentMatchId, TeamCompetingId, Score)
	values (@MatchupId, @ParentMatchId, @TeamCompetingId, @Score);

	select @id = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[spMatchupEntry_Update]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spMatchupEntry_Update]
	@id int,
	@TeamCompetingId int = null,
	@Score int = null
AS
BEGIN
	SET NOCOUNT ON;

    update dbo.MatchupEntries
	set TeamCompetingId = @TeamCompetingId, Score = @Score
	where id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[spMatchups_GetByTournament]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spMatchups_GetByTournament]
	@TournamentId int
AS
BEGIN
	SET NOCOUNT ON;

    select m.*
	from dbo.Matchup m
	where m.TournamentId = @TournamentId;
END
GO
/****** Object:  StoredProcedure [dbo].[spMatchups_Update]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spMatchups_Update]
	@id int,
	@WinnerId int
AS
BEGIN
	SET NOCOUNT ON;

    update dbo.Matchup
	set WinnerId = @WinnerId
	where id = @id;

END
GO
/****** Object:  StoredProcedure [dbo].[spPeople_GetAll]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spPeople_GetAll]
AS
BEGIN
	SET NOCOUNT ON;

    select * from dbo.People
END
GO
/****** Object:  StoredProcedure [dbo].[spPeople_GetByLastName]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spPeople_GetByLastName]
	@LastName nvarchar(100)
AS
BEGIN
	SET NOCOUNT ON;

    select *
	from dbo.People p
	where p.LastName = @LastName;
	
END
GO
/****** Object:  StoredProcedure [dbo].[spPeople_Insert]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spPeople_Insert] 
	@FirstName nvarchar(100),
	@LastName nvarchar(100),
	@EmailAddress nvarchar(50),
	@CellphoneNumber nvarchar(20),
	@id int = 0 output
AS
BEGIN
	SET NOCOUNT ON;

    insert into dbo.People (FirstName, LastName, EmailAddress, CellphoneNumber)
	values (@FirstName, @LastName, @EmailAddress, @CellphoneNumber);

	select @id = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[spPrizes_GetAll]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spPrizes_GetAll]
AS
BEGIN
	SET NOCOUNT ON;

    select * from dbo.Prizes
END
GO
/****** Object:  StoredProcedure [dbo].[spPrizes_GetByTournament]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spPrizes_GetByTournament]
	@TournamentId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	select p.*
	from dbo.Prizes p
	inner join dbo.TournamentPrizes t on p.id = t.PrizeId
	where t.TournamentId = @TournamentId
END
GO
/****** Object:  StoredProcedure [dbo].[spPrizes_Insert]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spPrizes_Insert]
	@PlaceNumber int,
	@PlaceName nvarchar(50),
	@PrizeAmount money,
	@PrizePercentage float,
	@id int = 0 output
AS
BEGIN
	SET NOCOUNT ON;
	
	insert into dbo.Prizes (PlaceNumber, PlaceName, PrizeAmount, PrizePercentage)
	values (@PlaceNumber, @PlaceName, @PrizeAmount, @PrizePercentage);

	select @id = SCOPE_IDENTITY();

END
GO
/****** Object:  StoredProcedure [dbo].[spTeam_GetByTournament]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTeam_GetByTournament]
	@TournamentId int
AS
BEGIN
	SET NOCOUNT ON;

    select t.*
	from dbo.Teams teams
	inner join dbo.TournamentEntries te on teams.id = te.TeamId
	inner join dbo.Tournaments t on te.TournamentId = t.id
	where t.id = @TournamentId
END
GO
/****** Object:  StoredProcedure [dbo].[spTeamMembers_GetByTeam]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTeamMembers_GetByTeam]
	@TeamId int
AS
BEGIN
	SET NOCOUNT ON;

    select p.*
	from dbo.TeamMembers tm
	inner join dbo.People p on tm.PersonId = p.id
	where tm.TeamId = @TeamId
END
GO
/****** Object:  StoredProcedure [dbo].[spTeamMembers_Insert]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTeamMembers_Insert] 
	@TeamId int,
	@PersonId int,
	@id int = 0 output
AS
BEGIN
	SET NOCOUNT ON;

    insert into dbo.TeamMembers(TeamId, PersonId)
	values (@TeamId, @PersonId)

	select @id = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[spTeams_GetAll]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTeams_GetAll]
AS
BEGIN
	SET NOCOUNT ON;

    select * from dbo.Teams
END
GO
/****** Object:  StoredProcedure [dbo].[spTeams_Insert]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTeams_Insert]
	@TeamName nvarchar(50),
	@id int = 0 output
AS
BEGIN
	SET NOCOUNT ON;

    insert into dbo.Teams(TeamName)
	values (@TeamName)

	select @id = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[spTournamentEntries_Insert]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTournamentEntries_Insert]
	@TournamentId int,
	@TeamId int,
	@id int = 0 output
AS
BEGIN
	SET NOCOUNT ON;

    insert into dbo.TournamentEntries (TournamentId, TeamId)
	values (@TournamentId, @TeamId);

	select @id = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[spTournamentPrizes_Insert]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTournamentPrizes_Insert]
	@TournamentId int,
	@PrizeId int,
	@id int = 0 output
AS
BEGIN
	SET NOCOUNT ON;

    insert into dbo.TournamentPrizes (TournamentId, PrizeId)
	values (@TournamentId, @PrizeId);

	select @id = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[spTournaments_Complete]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTournaments_Complete]
	@id int
AS
BEGIN
	SET NOCOUNT ON;

    update dbo.Tournaments
	set Active = 0
	where id = @id;
END
GO
/****** Object:  StoredProcedure [dbo].[spTournaments_GetAll]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTournaments_GetAll]
	
AS
BEGIN
	SET NOCOUNT ON;

	select * from dbo.Tournaments
	where Active = 1;
END
GO
/****** Object:  StoredProcedure [dbo].[spTournaments_Insert]    Script Date: 16/10/2020 11:58:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spTournaments_Insert]
	@TournamentName nvarchar(50),
	@EntryFee money,
	@Active bit,
	@id int = 0 output
AS
BEGIN
	SET NOCOUNT ON;

    insert into dbo.Tournaments (TournamentName, EntryFee, Active)
	values (@TournamentName, @EntryFee, @Active)

	select @id = SCOPE_IDENTITY();
END
GO
USE [master]
GO
ALTER DATABASE [Tournament_tracker] SET  READ_WRITE 
GO
