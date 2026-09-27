using MCQApi.Data;
using MCQApi.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace MCQApi.Controllers;

[ApiController]
[Route("api/[controller]")]
public class QuestionsController : ControllerBase
{
    private readonly MCQDbContext _context;

    public QuestionsController(MCQDbContext context)
    {
        _context = context;
    }

    // GET: api/Questions
    [HttpGet]
    public async Task<ActionResult<IEnumerable<MCQQuestion>>>
        GetQuestions()
    {
        var questions = await _context.Questions
            .Include(q => q.Subject)
            .Where(q => q.IsActive)
            .ToListAsync();

        return Ok(questions);
    }

    // GET: api/Questions/1
    [HttpGet("{id}")]
    public async Task<ActionResult<MCQQuestion>>
        GetQuestion(int id)
    {
        var question = await _context.Questions
            .Include(q => q.Subject)
            .FirstOrDefaultAsync(q => q.Id == id);

        if (question == null)
        {
            return NotFound(new
            {
                message = "Question not found"
            });
        }

        return Ok(question);
    }

    // GET: api/Questions/subject/1
    [HttpGet("subject/{subjectId}")]
    public async Task<ActionResult<IEnumerable<MCQQuestion>>>
        GetQuestionsBySubject(int subjectId)
    {
        var questions = await _context.Questions
            .Where(q =>
                q.SubjectId == subjectId &&
                q.IsActive)
            .Include(q => q.Subject)
            .ToListAsync();

        return Ok(questions);
    }

    // POST: api/Questions
    [HttpPost]
    public async Task<ActionResult<MCQQuestion>>
        CreateQuestion(MCQQuestion question)
    {
        var subjectExists = await _context.Subjects
            .AnyAsync(s => s.Id == question.SubjectId);

        if (!subjectExists)
        {
            return BadRequest(new
            {
                message = "Subject does not exist"
            });
        }

        question.Id = 0;
        question.CreatedAt = DateTime.UtcNow;

        _context.Questions.Add(question);

        await _context.SaveChangesAsync();

        return CreatedAtAction(
            nameof(GetQuestion),
            new { id = question.Id },
            question
        );
    }

    // PUT: api/Questions/1
    [HttpPut("{id}")]
    public async Task<IActionResult> UpdateQuestion(
        int id,
        MCQQuestion updatedQuestion)
    {
        if (id != updatedQuestion.Id)
        {
            return BadRequest(new
            {
                message = "ID mismatch"
            });
        }

        var question = await _context.Questions
            .FindAsync(id);

        if (question == null)
        {
            return NotFound(new
            {
                message = "Question not found"
            });
        }

        var subjectExists = await _context.Subjects
            .AnyAsync(s => s.Id == updatedQuestion.SubjectId);

        if (!subjectExists)
        {
            return BadRequest(new
            {
                message = "Subject does not exist"
            });
        }

        question.Question = updatedQuestion.Question;
        question.OptionA = updatedQuestion.OptionA;
        question.OptionB = updatedQuestion.OptionB;
        question.OptionC = updatedQuestion.OptionC;
        question.OptionD = updatedQuestion.OptionD;
        question.CorrectAnswer = updatedQuestion.CorrectAnswer;
        question.Explanation = updatedQuestion.Explanation;
        question.SubjectId = updatedQuestion.SubjectId;
        question.IsActive = updatedQuestion.IsActive;

        await _context.SaveChangesAsync();

        return Ok(question);
    }

    // DELETE: api/Questions/1
    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteQuestion(int id)
    {
        var question = await _context.Questions
            .FindAsync(id);

        if (question == null)
        {
            return NotFound(new
            {
                message = "Question not found"
            });
        }

        _context.Questions.Remove(question);

        await _context.SaveChangesAsync();

        return Ok(new
        {
            message = "Question deleted successfully"
        });
    }
}