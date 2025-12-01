-- ========================================
-- Organization Table
-- ========================================
CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL,

-- ========================================
-- Insert sample data: Organizations
-- ========================================
INSERT INTO organization (name, description, contact_email, logo_filename)
VALUES
('BrightFuture Builders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png');


-- ========================================
-- Project Table
-- ========================================
CREATE TABLE project (
    project_id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL REFERENCES organization(organization_id),
    title VARCHAR(200) NOT NULL,
    description TEXT,
    location VARCHAR(200),
    start_date DATE,
    end_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO project (organization_id, title, description, location, start_date, end_date)
VALUES
((SELECT organization_id FROM organization WHERE name = 'BrightFuture Builders'),
 'Community Playground Renovation', 'Renovating and upgrading an old community playground for safer, modern equipment.', 'Maplewood Park', '2025-06-01', '2025-06-15'),
((SELECT organization_id FROM organization WHERE name = 'BrightFuture Builders'),
 'Accessible Ramp Installation', 'Installing wheelchair-accessible ramps for community centers and local businesses.', 'Downtown District', '2025-07-01', '2025-07-10'),
((SELECT organization_id FROM organization WHERE name = 'BrightFuture Builders'),
 'Neighborhood Clean-Up Day', 'Coordinating a large-scale cleanup event for public areas and parks.', 'East Riverside', '2025-05-12', '2025-05-12'),
((SELECT organization_id FROM organization WHERE name = 'BrightFuture Builders'),
 'Community Tool Library Setup', 'Establishing a lending library for tools and materials to support local DIY projects.', 'Civic Center', '2025-08-01', '2025-09-01'),
((SELECT organization_id FROM organization WHERE name = 'BrightFuture Builders'),
 'Solar Streetlight Installation', 'Installing solar-powered streetlights in low-income neighborhoods.', 'Westfield', '2025-09-10', '2025-09-30');

-- GreenHarvest Growers Projects
INSERT INTO project (organization_id, title, description, location, start_date, end_date)
VALUES
((SELECT organization_id FROM organization WHERE name = 'GreenHarvest Growers'),
 'Urban Garden Expansion', 'Expanding existing community gardens with new plots and drip irrigation systems.', 'Greenway Gardens', '2025-04-15', '2025-05-15'),
((SELECT organization_id FROM organization WHERE name = 'GreenHarvest Growers'),
 'Composting Workshop Series', 'Teaching residents how to compost organic waste effectively.', 'Community Resource Center', '2025-06-05', '2025-06-20'),
((SELECT organization_id FROM organization WHERE name = 'GreenHarvest Growers'),
 'Farm-to-Table Youth Program', 'An educational project that connects local schools to sustainable farming practices.', 'Jefferson Middle School', '2025-07-10', '2025-08-05'),
((SELECT organization_id FROM organization WHERE name = 'GreenHarvest Growers'),
 'Pollinator Habitat Project', 'Creating small wildflower habitats to support local bee populations.', 'City Park', '2025-05-20', '2025-06-10'),
((SELECT organization_id FROM organization WHERE name = 'GreenHarvest Growers'),
 'Hydroponic Garden Setup', 'Building an indoor hydroponic demonstration system for year-round education.', 'GreenHarvest HQ', '2025-09-01', '2025-09-25');

-- UnityServe Volunteers Projects
INSERT INTO project (organization_id, title, description, location, start_date, end_date)
VALUES
((SELECT organization_id FROM organization WHERE name = 'UnityServe Volunteers'),
 'Senior Companion Program', 'Matching volunteers with elderly residents in need of companionship and assistance.', 'Citywide', '2025-05-01', '2025-07-31'),
((SELECT organization_id FROM organization WHERE name = 'UnityServe Volunteers'),
 'School Supply Drive', 'Collecting and distributing essential school supplies for underprivileged children.', 'Community Center', '2025-07-15', '2025-08-10'),
((SELECT organization_id FROM organization WHERE name = 'UnityServe Volunteers'),
 'Holiday Meal Distribution', 'Organizing and delivering meals to families during the winter holidays.', 'Various Locations', '2025-12-10', '2025-12-24'),
((SELECT organization_id FROM organization WHERE name = 'UnityServe Volunteers'),
 'Youth Mentorship Initiative', 'Pairing at-risk youth with positive role models for mentorship and support.', 'Downtown YMCA', '2025-06-20', '2025-09-30'),
((SELECT organization_id FROM organization WHERE name = 'UnityServe Volunteers'),
 'Blood Donation Campaign', 'Coordinating a community-wide blood donation event with local hospitals.', 'Health Pavilion', '2025-10-05', '2025-10-10');



-- ========================================
-- Category Table
-- ========================================
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- ========================================
-- Project_Category (Many-to-Many Join Table)
-- ========================================
CREATE TABLE project_category (
    project_id INTEGER NOT NULL REFERENCES project(project_id),
    category_id INTEGER NOT NULL REFERENCES category(category_id),
    PRIMARY KEY (project_id, category_id)
);


INSERT INTO category (name, description)
VALUES
('Environment', 'Projects focused on environmental sustainability, conservation, and green initiatives.'),
('Community Development', 'Initiatives that strengthen local communities through construction, education, and engagement.'),
('Education', 'Programs centered on teaching, mentoring, and skill development.');


-- ========================================
-- BrightFuture Builders Projects → Categories
-- ========================================

INSERT INTO project_category (project_id, category_id)
VALUES
((SELECT project_id FROM project WHERE title = 'Community Playground Renovation'),
 (SELECT category_id FROM category WHERE name = 'Community Development')),
((SELECT project_id FROM project WHERE title = 'Accessible Ramp Installation'),
 (SELECT category_id FROM category WHERE name = 'Community Development')),
((SELECT project_id FROM project WHERE title = 'Neighborhood Clean-Up Day'),
 (SELECT category_id FROM category WHERE name = 'Environment')),
((SELECT project_id FROM project WHERE title = 'Community Tool Library Setup'),
 (SELECT category_id FROM category WHERE name = 'Community Development')),
((SELECT project_id FROM project WHERE title = 'Solar Streetlight Installation'),
 (SELECT category_id FROM category WHERE name = 'Environment'));

-- ========================================
-- GreenHarvest Growers Projects → Categories
-- ========================================

INSERT INTO project_category (project_id, category_id)
VALUES
((SELECT project_id FROM project WHERE title = 'Urban Garden Expansion'),
 (SELECT category_id FROM category WHERE name = 'Environment')),
((SELECT project_id FROM project WHERE title = 'Composting Workshop Series'),
 (SELECT category_id FROM category WHERE name = 'Education')),
((SELECT project_id FROM project WHERE title = 'Farm-to-Table Youth Program'),
 (SELECT category_id FROM category WHERE name = 'Education')),
((SELECT project_id FROM project WHERE title = 'Pollinator Habitat Project'),
 (SELECT category_id FROM category WHERE name = 'Environment')),
((SELECT project_id FROM project WHERE title = 'Hydroponic Garden Setup'),
 (SELECT category_id FROM category WHERE name = 'Education'));

-- ========================================
-- UnityServe Volunteers Projects → Categories
-- ========================================

INSERT INTO project_category (project_id, category_id)
VALUES
((SELECT project_id FROM project WHERE title = 'Senior Companion Program'),
 (SELECT category_id FROM category WHERE name = 'Community Development')),
((SELECT project_id FROM project WHERE title = 'School Supply Drive'),
 (SELECT category_id FROM category WHERE name = 'Education')),
((SELECT project_id FROM project WHERE title = 'Holiday Meal Distribution'),
 (SELECT category_id FROM category WHERE name = 'Community Development')),
((SELECT project_id FROM project WHERE title = 'Youth Mentorship Initiative'),
 (SELECT category_id FROM category WHERE name = 'Education')),
((SELECT project_id FROM project WHERE title = 'Blood Donation Campaign'),
 (SELECT category_id FROM category WHERE name = 'Community Development'));
