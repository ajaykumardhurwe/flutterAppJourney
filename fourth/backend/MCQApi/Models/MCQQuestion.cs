namespace MCQApi.Models;

public class MCQQuestion
{
    public int Id { get; set; }

    public string Question { get; set; } = string.Empty;

    public string OptionA { get; set; } = string.Empty;

    public string OptionB { get; set; } = string.Empty;

    public string OptionC { get; set; } = string.Empty;

    public string OptionD { get; set; } = string.Empty;

    public int CorrectAnswer { get; set; }

    public string? Explanation { get; set; }

    public int SubjectId { get; set; }

    public Subject? Subject { get; set; }

    public bool IsActive { get; set; } = true;

    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
}