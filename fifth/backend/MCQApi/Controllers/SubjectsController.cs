using MCQApi.Data;
using MCQApi.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace MCQApi.Controllers;

[ApiController]
[Route("api/[controller]")]
public class SubjectsController : ControllerBase
{
    private readonly MCQDbContext _context;

    public SubjectsController(MCQDbContext context)
    {
        _context = context;
    }

    // GET: api/Subjects
    [HttpGet]
    public async Task<ActionResult<IEnumerable<Subject>>> GetSubjects()
    {
        var subjects = await _context.Subjects
            .Include(s => s.Questions)
            .ToListAsync();

        return Ok(subjects);
    }

    // GET: api/Subjects/1
    [HttpGet("{id}")]
    public async Task<ActionResult<Subject>> GetSubject(int id)
    {
        var subject = await _context.Subjects
            .Include(s => s.Questions)
            .FirstOrDefaultAsync(s => s.Id == id);

        if (subject == null)
        {
            return NotFound(new
            {
                message = "Subject not found"
            });
        }

        return Ok(subject);
    }

    // POST: api/Subjects
    [HttpPost]
    public async Task<ActionResult<Subject>> CreateSubject(
        Subject subject)
    {
        subject.Id = 0;
        subject.CreatedAt = DateTime.UtcNow;

        _context.Subjects.Add(subject);

        await _context.SaveChangesAsync();

        return CreatedAtAction(
            nameof(GetSubject),
            new { id = subject.Id },
            subject
        );
    }

    // PUT: api/Subjects/1
    [HttpPut("{id}")]
    public async Task<IActionResult> UpdateSubject(
        int id,
        Subject updatedSubject)
    {
        if (id != updatedSubject.Id)
        {
            return BadRequest(new
            {
                message = "ID mismatch"
            });
        }

        var subject = await _context.Subjects
            .FindAsync(id);

        if (subject == null)
        {
            return NotFound(new
            {
                message = "Subject not found"
            });
        }

        subject.Name = updatedSubject.Name;
        subject.Description = updatedSubject.Description;
        subject.IsActive = updatedSubject.IsActive;

        await _context.SaveChangesAsync();

        return Ok(subject);
    }

    // DELETE: api/Subjects/1
    [HttpDelete("{id}")]
    public async Task<IActionResult> DeleteSubject(int id)
    {
        var subject = await _context.Subjects
            .FindAsync(id);

        if (subject == null)
        {
            return NotFound(new
            {
                message = "Subject not found"
            });
        }

        _context.Subjects.Remove(subject);

        await _context.SaveChangesAsync();

        return Ok(new
        {
            message = "Subject deleted successfully"
        });
    }
}