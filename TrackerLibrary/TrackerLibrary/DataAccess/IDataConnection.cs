﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using TrackerLibrary.Models;

namespace TrackerLibrary.DataAccess
{
    public interface IDataConnection
    {
        PrizeModel CreatePrize(PrizeModel model);
        PersonModel CreatePerson(PersonModel model);
        TeamModel CreateTeam(TeamModel model);
        TournamentModel CreateTournament(TournamentModel model);
        void UpdateMatchup(MatchupModel model);

        void CompleteTournament(TournamentModel model);
        List<PersonModel> GetPerson_All();
        List<TeamModel> GetTeams_All();
        List<PrizeModel> GetPrizes_All();
        List<PrizeModel> GetPrizes_ByTournament(TournamentModel model);
        List<TournamentModel> GetTournaments_All();
        
    }
}
