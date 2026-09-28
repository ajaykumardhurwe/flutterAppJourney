using MCQApi.Data;
using MCQApi.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace MCQApi.Controllers;

[ApiController]
[Route("api/[controller]")]
public class ProfilesController : ControllerBase
{
    private readonly MCQDbContext _context;

    public ProfilesController(MCQDbContext context)
    {
        _context = context;
    }

    // GET: api/Profiles
    [HttpGet]
    public async Task<ActionResult<IEnumerable<UserProfile>>>
        GetProfiles()
    {
        var profiles = await _context.UserProfiles
            .Where(p => p.IsActive)
            .ToListAsync();

        return Ok(profiles);
    }

    // GET: api/Profiles/1
    [HttpGet("{id}")]
    public async Task<ActionResult<UserProfile>>
        GetProfile(int id)
    {
        var profile = await _context.UserProfiles
            .FirstOrDefaultAsync(p => p.Id == id);

        if (profile == null)
        {
            return NotFound(new
            {
                message = "Profile not found"
            });
        }

        return Ok(profile);
    }

    // POST: api/Profiles
    [HttpPost]
    public async Task<ActionResult<UserProfile>>
        CreateProfile(UserProfile profile)
    {
        profile.Id = 0;
        profile.CreatedAt = DateTime.UtcNow;
        profile.UpdatedAt = null;
        profile.IsActive = true;

        _context.UserProfiles.Add(profile);

        await _context.SaveChangesAsync();

        return CreatedAtAction(
            nameof(GetProfile),
            new { id = profile.Id },
            profile
        );
    }

    // PUT: api/Profiles/1
    [HttpPut("{id}")]
    public async Task<ActionResult<UserProfile>>
        UpdateProfile(
            int id,
            UserProfile updatedProfile)
    {
        if (id != updatedProfile.Id)
        {
            return BadRequest(new
            {
                message = "ID mismatch"
            });
        }

        var profile = await _context.UserProfiles
            .FindAsync(id);

        if (profile == null)
        {
            return NotFound(new
            {
                message = "Profile not found"
            });
        }

        profile.Name = updatedProfile.Name;
        profile.Email = updatedProfile.Email;
        profile.Phone = updatedProfile.Phone;
        profile.Bio = updatedProfile.Bio;
        profile.IsActive = updatedProfile.IsActive;
        profile.UpdatedAt = DateTime.UtcNow;

        await _context.SaveChangesAsync();

        return Ok(profile);
    }

    // DELETE: api/Profiles/1
    [HttpDelete("{id}")]
    public async Task<IActionResult>
        DeleteProfile(int id)
    {
        var profile = await _context.UserProfiles
            .FindAsync(id);

        if (profile == null)
        {
            return NotFound(new
            {
                message = "Profile not found"
            });
        }

        _context.UserProfiles.Remove(profile);

        await _context.SaveChangesAsync();

        return Ok(new
        {
            message = "Profile deleted successfully"
        });
    }
}