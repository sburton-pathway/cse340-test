// Import express using ESM syntax
import express from 'express';
import { fileURLToPath } from 'url';
import path from 'path';
// import { testConnection } from './src/models/db.js';
// import { getAllOrganizations } from './src/models/organizations.js';
// import { getAllProjects } from './src/models/projects.js';
// import { getAllCategories } from './src/models/categories.js';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const NODE_ENV = process.env.NODE_ENV || 'production';

// Define the port number the server will listen on
const PORT = process.env.PORT || 3000;

// Create an instance of an Express application
const app = express();

// Serve static files from the public directory
app.use(express.static(path.join(__dirname, 'public')));

// Set EJS as the templating engine
app.set('view engine', 'ejs');

// Tell Express where to find your templates
app.set('views', path.join(__dirname, 'src/views'));


/**
 * Routes
 */
app.get('/', (req, res) => {
    const title = 'Home';
    res.render('home', { title });
});

app.get('/partners', async (req, res) => {

    // const organizations = await getAllOrganizations();
    const organizations = []; // Placeholder until the actual function is uncommented
    const title = 'Our Partners';

    res.render('partners', { title, organizations });
});

app.get('/projects', async (req, res) => {
    
    // const projects = await getAllProjects();
    const projects = []; // Placeholder until the actual function is uncommented
    const title = 'Service Projects';
    res.render('projects', { title, projects });
});

app.get('/categories', async (req, res) => {
    
    // const categories = await getAllCategories();
    const categories = []; // Placeholder until the actual function is uncommented
    const title = 'Service Categories';
    res.render('categories', { title, categories });
});

// Start the server and listen on the specified port
app.listen(PORT, async () => {
    try {
        console.log(`DB_URL: ${process.env.DB_URL}`);
        // await testConnection();
        console.log(`Server is running on http://127.0.0.1:${PORT}`);
    } catch (error) {
        console.error('Database setup failed:', error.message);
        process.exit(1);
    }
});