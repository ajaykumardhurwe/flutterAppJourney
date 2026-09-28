using MCQApi.Models;
using Microsoft.EntityFrameworkCore;

namespace MCQApi.Data;

public class MCQDbContext : DbContext
{
    public MCQDbContext(
        DbContextOptions<MCQDbContext> options)
        : base(options)
    {
    }

    public DbSet<Subject> Subjects { get; set; }

    public DbSet<MCQQuestion> Questions { get; set; }

    public DbSet<UserProfile> UserProfiles {get; set;}

    protected override void OnModelCreating(
        ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<Subject>()
            .HasMany(s => s.Questions)
            .WithOne(q => q.Subject)
            .HasForeignKey(q => q.SubjectId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}