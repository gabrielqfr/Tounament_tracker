using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection.Metadata.Ecma335;
using System.Text;
using System.Threading.Tasks;

namespace TrackerLibrary
{
    /// <summary>
    /// Represents a prize in the tournament.
    /// </summary>
    public class PrizeModel
    {
        /// <summary>
        /// Represents the position in the ranks the team have to be in order to win this prize.
        /// </summary>
        public int PlaceNumber { get; set; }
        /// <summary>
        /// The name of the position in the ranks.
        /// </summary>
        public string PlaceName { get; set; }
        /// <summary>
        /// The value of the prize.
        /// </summary>
        public decimal PrizeAmount { get; set; }
        /// <summary>
        /// The percentage of the total amount paid in entry fees that become the prize.
        /// </summary>
        public double PrizePercentage { get; set; }
    }
}
