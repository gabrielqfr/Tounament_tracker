namespace TrackerLibrary.Models
{
    /// <summary>
    /// Represents a prize in the tournament.
    /// </summary>
    public class PrizeModel
    {
        /// <summary>
        /// The unique id identifier for the prize.
        /// </summary>
        public int Id { get; set; }
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

        /// <summary>
        /// Default constructor.
        /// </summary>
        public PrizeModel()
        {

        }

        /// <summary>
        /// Override constructor for parsing the values.
        /// </summary>
        public PrizeModel(string placeName, string placeNumber, string prizeAmount, string prizePercentage)
        {
            PlaceName = placeName;

            int.TryParse(placeNumber, out int placeNumberValue);
            PlaceNumber = placeNumberValue;

            decimal.TryParse(prizeAmount, out decimal prizeAmountValue);
            PrizeAmount = prizeAmountValue;

            double.TryParse(prizePercentage, out double prizePercentageValue);
            PrizePercentage = prizePercentageValue;
        }
    }
}
