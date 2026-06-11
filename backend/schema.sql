CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(50) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role VARCHAR DEFAULT 'student' CHECK (role IN ('student' , 'business')),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE student_profiles (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users ON DELETE CASCADE,
    full_name VARCHAR(255) NOT NULL,
    university VARCHAR NOT NULL,
    bio VARCHAR,
    hourly_rate INT NOT NULL,
    profile_image_url VARCHAR,
    portfolio_url VARCHAR,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE business_profiles (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    profile_image_url VARCHAR,
    bio VARCHAR,
    address VARCHAR NOT NULL,
    sector VARCHAR NOT NULL,
    company_size INT NOT NULL,
    website_url VARCHAR,
    phone INT NOT NULL,
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE skills (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE student_skills (
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES student_profiles ON DELETE CASCADE,
    skill_id INT REFERENCES skills ON DELETE CASCADE
);

CREATE TABLE gigs (
    id SERIAL PRIMARY KEY,
    business_id INT REFERENCES business_profiles ON DELETE CASCADE,
    title VARCHAR NOT NULL,
    description VARCHAR NOT NULL,
    budget_min INT NOT NULL,
    budget_max INT NOT NULL,
    deadline DATE NOT NULL,
    status VARCHAR DEFAULT 'open' CHECK (status IN ('open' , 'in_progress', 'completed' , 'cancelled')),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE gig_skills (
    id SERIAL PRIMARY KEY,
    gig_id INT REFERENCES gigs ON DELETE CASCADE,
    skill_id INT REFERENCES skills ON DELETE CASCADE
);

CREATE TABLE proposals (
    id SERIAL PRIMARY KEY,
    gig_id INT REFERENCES gigs ON DELETE CASCADE,
    student_id INT REFERENCES student_profiles ON DELETE CASCADE,
    cover_letter VARCHAR NOT NULL,
    proposed_price INT NOT NULL,
    cv_url VARCHAR NOT NULL,
    status VARCHAR DEFAULT 'requires' CHECK (status IN ('pending' , 'accepted', 'rejected')),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE contracts (
    id SERIAL PRIMARY KEY,
    proposal_id INT REFERENCES proposals ON DELETE CASCADE,
    student_id INT REFERENCES student_profiles ON DELETE CASCADE,
    business_id INT REFERENCES business_profiles ON DELETE CASCADE,
    description VARCHAR NOT NULL,
    agreed_price INT NOT NULL,
    deadline DATE NOT NULL,
    status VARCHAR DEFAULT 'disputed' CHECK (status IN ('active' , 'completed', 'cancelled' , 'disputed')),
    payment_status VARCHAR DEFAULT 'unpaid' CHECK (payment_status IN ('paid' , 'unpaid', 'refunded')),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE ratings (
    id SERIAL PRIMARY KEY,
    contract_id INT REFERENCES contracts ON DELETE CASCADE,
    student_id INT REFERENCES student_profiles ON DELETE CASCADE,
    business_id INT REFERENCES business_profiles ON DELETE CASCADE,
    score SMALLINT NOT NULL CHECK (score >= 1 AND score <= 5),
    comment VARCHAR,
    created_at TIMESTAMP DEFAULT NOW()
);